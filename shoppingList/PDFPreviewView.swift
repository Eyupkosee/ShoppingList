import SwiftUI
import RevenueCatUI
import RevenueCat
import PDFKit
import UniformTypeIdentifiers

struct PDFPreviewView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ListDetailViewModel
    @State private var downloadState: DownloadState = .idle
    @State private var pdfURL: URL?
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showPaywall = false // Yeni ekledik
    @Environment(\.presentationMode) var presentationMode

    enum DownloadState: Identifiable, Equatable {
        case idle
        case downloaded(URL)
        
        var id: String {
            switch self {
            case .idle:
                return "idle"
            case .downloaded(let url):
                return url.absoluteString
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                PDFKitView(list: viewModel.list)
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
                        if let error = error {
                            print("Hata: Abonelik durumu alınırken bir sorun oluştu - \(error.localizedDescription)")
                            return
                        }
                        
                        if purchaserInfo?.entitlements.active["premium"] != nil {
                            self.downloadPDF()
                        } else {
                            DispatchQueue.main.async {
                                self.showPaywall = true
                            }
                        }
                    }
                }) {
                    Text("PDF İndir")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.theme.tabBarBackground)
                        .cornerRadius(10)
                }
            }
            .background(Color.gray.opacity(0.1))
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
        .sheet(item: Binding(
            get: { downloadState == .idle ? nil : downloadState },
            set: { _ in downloadState = .idle }
        )) { state in
            if case .downloaded(let url) = state {
                ShareSheet(activityItems: [url])
            }
        }
        .alert("Hata", isPresented: $showError) {
            Button("Tamam", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color.theme.mintPrimary)
                        Text("Geri")
                            .foregroundColor(Color.theme.mintPrimary)
                    }
                }
            }
        }
    }
    
    func downloadPDF() {
        guard let document = PDFKitView(list: viewModel.list).createPDFDocument() else {
            errorMessage = "PDF oluşturulamadı"
            showError = true
            return
        }
        
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        let pdfURL = temporaryDirectoryURL.appendingPathComponent("ShoppingList-\(UUID().uuidString).pdf")
        
        do {
            document.write(to: pdfURL)
            self.pdfURL = pdfURL
            self.downloadState = .downloaded(pdfURL)
        } catch {
            errorMessage = "PDF kaydetme hatası: \(error.localizedDescription)"
            showError = true
        }
    }
}


struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // iPad için popover prezentasyon ayarları
        if let popover = controller.popoverPresentationController {
            popover.sourceView = UIView()
            popover.permittedArrowDirections = []
            popover.sourceRect = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 0, height: 0)
        }
        
        // Paylaşım seçeneklerini özelleştirme
        controller.excludedActivityTypes = [
            .assignToContact,
            .addToReadingList,
            .markupAsPDF
        ]
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct PDFKitView: UIViewRepresentable {
    let list: ShoppingList

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = createPDFDocument()
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}

    func createPDFDocument() -> PDFDocument? {
        // A4 boyutunu ayarlama
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // PDF Renderer oluşturma
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        // PDF verisini oluşturma
        let data = renderer.pdfData { (context) in
            context.beginPage()
            
            // Arka plan rengini ayarlama
            UIColor.systemBackground.setFill()
            context.cgContext.fill(pageRect)
            
            // Başlık ekleme
            let title = "Alışveriş Listesi"
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.label
            ]
            let titleString = NSAttributedString(string: title, attributes: titleAttributes)
            let titleSize = titleString.size()
            let titleX = (pageWidth - titleSize.width) / 2 // Başlığı ortalamak için x koordinatını ayarlama
            titleString.draw(at: CGPoint(x: titleX, y: 20))
            
            // Ürünleri ekleme
            let startY: CGFloat = 60
            let itemHeight: CGFloat = 30
            for (index, item) in list.items.enumerated() {
                let yPosition = startY + CGFloat(index) * itemHeight
                let backgroundColor = index % 2 == 0 ? UIColor.white : UIColor(white: 0.9, alpha: 1.0) // Daha açık gri
                backgroundColor.setFill()
                context.cgContext.fill(CGRect(x: 20, y: yPosition, width: pageWidth - 40, height: itemHeight))
                
                let itemAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 16),
                    .foregroundColor: UIColor.label
                ]
                let itemString = NSAttributedString(string: item.name, attributes: itemAttributes)
                itemString.draw(at: CGPoint(x: 30, y: yPosition + 5))
            }
        }
        
        // PDF verisini PDFDocument'e ekleme
        return PDFDocument(data: data)
    }
}

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
                    .frame(height: 500)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding()
                
                Spacer()

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
                .padding(.bottom, 20)
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
        
        // Otomatik ölçeklendirmeyi aktif ediyoruz
        pdfView.autoScales = true
 
        // PDF görünümünü her zaman açık modda göster
        pdfView.backgroundColor = .white
        
        // Scroll ve sayfa gösterim ayarları
//        pdfView.maxScaleFactor = 4.0
//        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.displayMode = .singlePageContinuous // Sürekli sayfa görünümü için değiştirdik
        pdfView.displaysPageBreaks = true
        pdfView.displayDirection = .vertical
        
        // Dark mode'dan etkilenmemesi için
        if #available(iOS 13.0, *) {
            pdfView.overrideUserInterfaceStyle = .light
        }
        
        // Sabit boyut kısıtlamalarını kaldırıyoruz
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}

    func createPDFDocument() -> PDFDocument? {
        // A4 boyutunu ayarlama (daha küçük ölçek için değerleri düşürdük)
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        // PDF Renderer oluşturma
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        
        // Sayfa başına maksimum öğe sayısı
        let itemHeight: CGFloat = 30
        let startY: CGFloat = 60 // Başlıktan sonraki başlangıç noktası
        let availableHeight = pageHeight - startY - 40 // Alt ve üst kenar boşlukları için
        let itemsPerPage = Int(availableHeight / itemHeight)
        
        // PDF verisini oluşturma
        let data = renderer.pdfData { (context) in
            // Öğeleri sayfalara böl
            let chunks = list.items.chunked(into: itemsPerPage)
            
            for (pageIndex, pageItems) in chunks.enumerated() {
                context.beginPage()
                
                // Arka plan rengini beyaz olarak ayarla
                UIColor.white.setFill()
                context.cgContext.fill(pageRect)
                
                // Başlık ekleme
                let titleAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 20),
                    .foregroundColor: UIColor.black
                ]
                let title = "Alışveriş Listesi - Sayfa \(pageIndex + 1)"
                let titleString = NSAttributedString(string: title, attributes: titleAttributes)
                let titleSize = titleString.size()
                let titleX = (pageWidth - titleSize.width) / 2
                titleString.draw(at: CGPoint(x: titleX, y: 20))
                
                // Sayfadaki öğeleri ekleme
                for (index, item) in pageItems.enumerated() {
                    let yPosition = startY + CGFloat(index) * itemHeight
                    let backgroundColor = index % 2 == 0 ? UIColor.white : UIColor(white: 0.9, alpha: 1.0)
                    backgroundColor.setFill()
                    context.cgContext.fill(CGRect(x: 20, y: yPosition, width: pageWidth - 40, height: itemHeight))
                    
                    let itemAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 16),
                        .foregroundColor: UIColor.black
                    ]
                    let itemString = NSAttributedString(string: item.name, attributes: itemAttributes)
                    itemString.draw(at: CGPoint(x: 30, y: yPosition + 5))
                }
            }
        }
        
        return PDFDocument(data: data)
    }
}

// Array extension for chunking
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

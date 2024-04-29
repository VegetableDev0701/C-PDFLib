#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <PDFKit/PDFKit.h>
#include "PDFComponent.h"

namespace ayra
{

static inline NSString* juceStringToNS (const juce::String& str)
{
    return [NSString stringWithUTF8String: str.toUTF8()];
}

static inline juce::String NOTojuceString (const NSString* str)
{
    return juce::String { str.UTF8String };
}

//==============================================================================

PDFComponent::PDFComponent()
{
    // Crea una istanza di PDFView
    pdfView = [[PDFView alloc] initWithFrame:NSMakeRect(0, 0, getWidth(), getHeight())];
    pdfView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

    // Aggiungi PDFView alla vista principale
    setView(pdfView);
}

PDFComponent::~PDFComponent()
{
}

void PDFComponent::paint(juce::Graphics& g)
{
}

void PDFComponent::resized()
{
    pdfView.frame = NSMakeRect(0, 0, getWidth(), getHeight());
}

//==============================================================================

void PDFComponent::loadPDF(const juce::String filePath)
{
#if JUCE_IOS
#elif JUCE_ANDROID
#elif JUCE_MAC

    // Specifica il percorso del file PDF
    NSString *pdfPath = juceStringToNS(filePath); // Sostituisci con il tuo percorso effettivo

    // Crea un URL dal percorso del file
    NSURL *pdfURL = [NSURL fileURLWithPath:pdfPath];

    // Carica il documento PDF dal percorso specificato
    PDFDocument *pdfDocument = [[PDFDocument alloc] initWithURL:pdfURL];

    // Imposta il documento PDF nella vista PDFView
    pdfView.document = pdfDocument;
    
#elif JUCE_WiNDOWS
#endif
}

void PDFComponent::setPageNumber(int pageNumber)
{
    if (pdfView)
    {
        if (pageNumber < getTotPagesNum())
        {
#if JUCE_IOS
#elif JUCE_ANDROID
#elif JUCE_MAC
            
            [pdfView goToPage:[pdfView.document pageAtIndex:pageNumber]];
            
#elif JUCE_WiNDOWS
#endif
        }
    }
}

int PDFComponent::getTotPagesNum()
{
    if (pdfView)
    {
#if JUCE_IOS
#elif JUCE_ANDROID
#elif JUCE_MAC


        return (int)pdfView.document.pageCount;

#elif JUCE_WiNDOWS
#endif
    }

    return 0;
}

int PDFComponent::getCurrentPageOnScreen()
{
    if (pdfView)
    {
#if JUCE_IOS
#elif JUCE_ANDROID
#elif JUCE_MAC
    

        PDFPage* currentPage = pdfView.currentPage;
        
        if (currentPage)
        {
            juce::String page { NOTojuceString(currentPage.label) };
            return page.getIntValue();
        }


    
#elif JUCE_WiNDOWS
#endif
    }
    
    return 0;
}

} // namespace ayra

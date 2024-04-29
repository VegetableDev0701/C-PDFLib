#pragma once

#include <JuceHeader.h>

namespace ayra
{

class PDFView;

class PDFComponent : public juce::NSViewComponent
{
public:
    PDFComponent();
    ~PDFComponent();

    void loadPDF(const juce::String filePath);
    void setPageNumber(int pageNumber);
    int getTotPagesNum();
    int getCurrentPageOnScreen();
    
    void paint(juce::Graphics& g) override;
    void resized() override;

private:

    PDFView* pdfView;
    int currentPageNumber;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (PDFComponent)
};

} // namespace ayra

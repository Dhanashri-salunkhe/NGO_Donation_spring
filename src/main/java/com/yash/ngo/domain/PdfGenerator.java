package com.yash.ngo.domain;

import com.itextpdf.io.font.constants.StandardFonts;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.yash.ngo.domain.Receipt;

import java.io.ByteArrayOutputStream;

public class PdfGenerator {

    public static byte[] generateReceiptPdf(Receipt receipt) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdfDoc = new PdfDocument(writer);
            Document document = new Document(pdfDoc);

            document.add(new Paragraph("Donation Receipt")
                    .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA_BOLD))
                    .setFontSize(18)
                    .setMarginBottom(20));

            document.add(new Paragraph("Receipt ID: " + receipt.getReceiptId())
                    .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA))
                    .setFontSize(12));
            document.add(new Paragraph("Name: " + receipt.getName())
                    .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA))
                    .setFontSize(12));
            document.add(new Paragraph("Amount: " + receipt.getAmount())
                    .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA))
                    .setFontSize(12));
            document.add(new Paragraph("Donation Date: " + receipt.getDonationDate())
                    .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA))
                    .setFontSize(12));
            document.add(new Paragraph("Payment ID: " + receipt.getPaymentId())
                    .setFont(PdfFontFactory.createFont(StandardFonts.HELVETICA))
                    .setFontSize(12));

            document.close();
            return baos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException("Error generating PDF receipt", e);
        }
    }
}

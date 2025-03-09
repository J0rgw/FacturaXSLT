<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fe="http://www.facturae.es/Facturae/2014/v3.2.1/Facturae">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Factura Simple</title>
                <link rel="stylesheet" type="text/css" href="../css/minimalista-style.css" />
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>FACTURA</h1>
                        <div class="invoice-number">#<xsl:value-of select="//fe:InvoiceHeader/fe:InvoiceNumber"/></div>
                        <div class="date">Emitida el <xsl:value-of select="//fe:InvoiceIssueData/fe:IssueDate"/></div>
                    </div>
                    
                    <div class="parties">
                        <div class="party">
                            <div class="party-title">DE</div>
                            <div class="party-name"><xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:CorporateName"/></div>
                            <div><xsl:value-of select="//fe:SellerParty/fe:TaxIdentification/fe:TaxIdentificationNumber"/></div>
                            <div><xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:Address"/></div>
                            <div><xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:PostCode"/> <xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:Town"/></div>
                        </div>
                        
                        <div class="party">
                            <div class="party-title">PARA</div>
                            <div class="party-name"><xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:CorporateName"/></div>
                            <div><xsl:value-of select="//fe:BuyerParty/fe:TaxIdentification/fe:TaxIdentificationNumber"/></div>
                            <div><xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:Address"/></div>
                            <div><xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:PostCode"/> <xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:Town"/></div>
                        </div>
                    </div>
                    
                    <table class="items">
                        <thead>
                            <tr>
                                <th>Descripción</th>
                                <th class="qty">Cantidad</th>
                                <th class="price">Precio</th>
                                <th class="total">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="//fe:InvoiceLine">
                                <tr>
                                    <td><xsl:value-of select="fe:ItemDescription"/></td>
                                    <td class="qty"><xsl:value-of select="fe:Quantity"/></td>
                                    <td class="price"><xsl:value-of select="fe:UnitPriceWithoutTax"/> €</td>
                                    <td class="total"><xsl:value-of select="fe:TotalAmount"/> €</td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                    
                    <table class="totals">
                        <tr>
                            <td class="label">Subtotal</td>
                            <td class="value"><xsl:value-of select="//fe:InvoiceTotals/fe:TotalGrossAmountBeforeTaxes"/> €</td>
                        </tr>
                        <xsl:for-each select="//fe:TaxesOutputs/fe:Tax">
                            <tr>
                                <td class="label">IVA (<xsl:value-of select="fe:TaxRate"/>%)</td>
                                <td class="value"><xsl:value-of select="fe:TaxAmount"/> €</td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td class="label grand-total">Total</td>
                            <td class="value grand-total"><xsl:value-of select="//fe:InvoiceTotals/fe:InvoiceTotal"/> €</td>
                        </tr>
                    </table>
                    
                    <div class="payment">
                        <div class="payment-title">INFORMACIÓN DE PAGO</div>
                        <div><strong>Método:</strong> <xsl:value-of select="//fe:PaymentDetails/fe:Installment/fe:PaymentMeans"/></div>
                        <div><strong>Vencimiento:</strong> <xsl:value-of select="//fe:PaymentDetails/fe:Installment/fe:InstallmentDueDate"/></div>
                        <xsl:if test="//fe:PaymentDetails/fe:Installment/fe:AccountToBeCredited/fe:IBAN">
                            <div><strong>IBAN:</strong> <xsl:value-of select="//fe:PaymentDetails/fe:Installment/fe:AccountToBeCredited/fe:IBAN"/></div>
                        </xsl:if>
                    </div>
                    
                    <div class="footer">
                        <p>Gracias por su confianza</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fe="http://www.facturae.es/Facturae/2014/v3.2.1/Facturae">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Factura Electrónica</title>
                <link rel="stylesheet" type="text/css" href="../css/empresarial-style.css" />
            </head>
            <body>
                <div class="invoice-container">
                    <!-- Cabecera de la factura -->
                    <div class="header">
                        <div class="logo">
                            <xsl:value-of select="//fe:SellerParty/fe:TaxIdentification/fe:TaxIdentificationNumber"/>
                        </div>
                        <div class="invoice-details">
                            <h1>FACTURA</h1>
                            <p><strong>Nº Factura:</strong> <xsl:value-of select="//fe:InvoiceHeader/fe:InvoiceNumber"/></p>
                            <p><strong>Serie:</strong> <xsl:value-of select="//fe:InvoiceHeader/fe:InvoiceSeriesCode"/></p>
                            <p><strong>Fecha:</strong> <xsl:value-of select="//fe:InvoiceIssueData/fe:IssueDate"/></p>
                        </div>
                    </div>
                    
                    <!-- Datos de las partes (emisor y receptor) -->
                    <div class="parties">
                        <div class="party">
                            <h2>EMISOR</h2>
                            <p><strong>Nombre:</strong> <xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:CorporateName"/></p>
                            <p><strong>NIF:</strong> <xsl:value-of select="//fe:SellerParty/fe:TaxIdentification/fe:TaxIdentificationNumber"/></p>
                            <p><strong>Dirección:</strong> <xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:Address"/></p>
                            <p><xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:PostCode"/> - <xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:Town"/> (<xsl:value-of select="//fe:SellerParty/fe:LegalEntity/fe:AddressInSpain/fe:Province"/>)</p>
                        </div>
                        <div class="party">
                            <h2>CLIENTE</h2>
                            <p><strong>Nombre:</strong> <xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:CorporateName"/></p>
                            <p><strong>NIF:</strong> <xsl:value-of select="//fe:BuyerParty/fe:TaxIdentification/fe:TaxIdentificationNumber"/></p>
                            <p><strong>Dirección:</strong> <xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:Address"/></p>
                            <p><xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:PostCode"/> - <xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:Town"/> (<xsl:value-of select="//fe:BuyerParty/fe:LegalEntity/fe:AddressInSpain/fe:Province"/>)</p>
                        </div>
                    </div>
                    
                    <!-- Detalles de la factura -->
                    <table>
                        <thead>
                            <tr>
                                <th>Concepto</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Importe</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="//fe:InvoiceLine">
                                <tr>
                                    <td><xsl:value-of select="fe:ItemDescription"/></td>
                                    <td><xsl:value-of select="fe:Quantity"/></td>
                                    <td><xsl:value-of select="fe:UnitPriceWithoutTax"/> €</td>
                                    <td><xsl:value-of select="fe:TotalAmount"/> €</td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                    
                    <!-- Resumen de importes -->
                    <div class="totals">
                        <div class="total-line">
                            <strong>Base Imponible:</strong>
                            <span><xsl:value-of select="//fe:InvoiceTotals/fe:TotalGrossAmountBeforeTaxes"/> €</span>
                        </div>
                        <xsl:for-each select="//fe:TaxesOutputs/fe:Tax">
                            <div class="total-line">
                                <strong>IVA (<xsl:value-of select="fe:TaxRate"/>%):</strong>
                                <span><xsl:value-of select="fe:TaxAmount"/> €</span>
                            </div>
                        </xsl:for-each>
                        <div class="total-line grand-total">
                            <strong>TOTAL:</strong>
                            <span><xsl:value-of select="//fe:InvoiceTotals/fe:InvoiceTotal"/> €</span>
                        </div>
                    </div>
                    
                    <!-- Información de pago -->
                    <div class="payment">
                        <h2>FORMA DE PAGO</h2>
                        <p><strong>Método:</strong> <xsl:value-of select="//fe:PaymentDetails/fe:Installment/fe:PaymentMeans"/></p>
                        <p><strong>Fecha vencimiento:</strong> <xsl:value-of select="//fe:PaymentDetails/fe:Installment/fe:InstallmentDueDate"/></p>
                        <xsl:if test="//fe:PaymentDetails/fe:Installment/fe:AccountToBeCredited/fe:IBAN">
                            <p><strong>IBAN:</strong> <xsl:value-of select="//fe:PaymentDetails/fe:Installment/fe:AccountToBeCredited/fe:IBAN"/></p>
                        </xsl:if>
                    </div>
                    
                    <!-- Pie de página -->
                    <div class="footer">
                        <p>Factura generada electrónicamente conforme al estándar FacturaE.</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
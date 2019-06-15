<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<xsl:template match="tfn">
<xsl:call-template name="LABEL"></xsl:call-template>
</xsl:template>
<xsl:template name="LABEL">
<xsl:variable name="service"> <xsl:value-of select="/tfn/serviceCode"/> </xsl:variable>
<xsl:variable name="hawb"> <xsl:value-of select="/tfn/consignmentReference"/> </xsl:variable>
<xsl:variable name="cref1"> <xsl:value-of select="/tfn/clientReference"/> </xsl:variable>
<xsl:variable name="dCompany"> <xsl:value-of select="/tfn/deliveryCompany"/> </xsl:variable>
<xsl:variable name="dAddress1"> <xsl:value-of select="/tfn/deliveryAddress1"/> </xsl:variable>
<xsl:variable name="dAddress2"> <xsl:value-of select="/tfn/deliveryAddress2"/> </xsl:variable>
<xsl:variable name="dAddress3"> <xsl:value-of select="/tfn/deliveryAddress3"/> </xsl:variable>
<xsl:variable name="dAddress4"> <xsl:value-of select="/tfn/deliveryAddress4"/> </xsl:variable>
<xsl:variable name="dCounty"> <xsl:value-of select="/tfn/deliveryCounty"/> </xsl:variable>
<xsl:variable name="dCountry"> <xsl:value-of select="/tfn/deliveryCountry"/> </xsl:variable>
<xsl:variable name="dPostcode"> <xsl:value-of select="/tfn/deliveryPostCode"/> </xsl:variable>
<xsl:variable name="dTelephone"> <xsl:value-of select="/tfn/deliveryTelephone"/> </xsl:variable>
<xsl:variable name="cCompany"> <xsl:value-of select="/tfn/collectionCompany"/></xsl:variable>
<xsl:variable name="cAddress1"> <xsl:value-of select="/tfn/collectionAddress1"/></xsl:variable>
<xsl:variable name="cAddress2"> <xsl:value-of select="/tfn/collectionAddress2"/></xsl:variable>
<xsl:variable name="cAddress3"> <xsl:value-of select="/tfn/collectionAddress3"/></xsl:variable>
<xsl:variable name="cAddress4"> <xsl:value-of select="/tfn/collectionAddress4"/></xsl:variable>
<xsl:variable name="cPostcode"> <xsl:value-of select="/tfn/collectionPostcode"/></xsl:variable>
<xsl:variable name="cCounty"> <xsl:value-of select="/tfn/collectionCounty"/></xsl:variable>
<xsl:variable name="cCountry"> <xsl:value-of select="/tfn/collectionCountry"/></xsl:variable>
<xsl:variable name="deliveryRound"> <xsl:value-of select="/tfn/deliveryRound"/> </xsl:variable>
<xsl:variable name="depot"> <xsl:value-of select="/tfn/depot"/> </xsl:variable>
<xsl:variable name="deliveryDepotNumber"> <xsl:value-of select="/tfn/deliveryDepotNumber"/> </xsl:variable>
<xsl:variable name="totalItem"> <xsl:value-of select="/tfn/totalItem"/> </xsl:variable>
<xsl:variable name="itemNo"> <xsl:value-of select="/tfn/itemNo"/> </xsl:variable>
<xsl:variable name="weight"> <xsl:value-of select="/tfn/weight"/> </xsl:variable>
<xsl:variable name="despatchDate"> <xsl:value-of select="/tfn/despatchDate"/> </xsl:variable>
<xsl:variable name="specialInstruction"> <xsl:value-of select="/tfn/specialInstruction"/> </xsl:variable>
<xsl:variable name="accountNo"> <xsl:value-of select="/tfn/accountNo"/> </xsl:variable>
<xsl:variable name="barcode"> <xsl:value-of select="/tfn/barcode" /> </xsl:variable>

^XA
~SD15^PR12^LH0,0
^FO25,15^GB690,790,2^FS
^FO35,35^A0N,130,120^FD<xsl:value-of select="$service"/>^FS
^FO635,25^FPR^A0N,120,130^FD<xsl:value-of select="$depot"/>^FS
^FO520,120^A0N,32,90^FD<xsl:value-of select="$deliveryRound"/>^FS
^FO25,160^GB690,0,2^FS
^FO35,165^A0N,18,18^FDConsignment Ref.^FS
^FO35,190^A0N,64,64^FD<xsl:value-of select="$hawb"/>^FS
^FO410,160^GB0,120,2^FS
^FO415,165^A0N,20,20^FD<xsl:value-of select="$cCompany"/>^FS
^FO415,187^A0N,20,20^FD<xsl:value-of select="$cAddress1"/> ^FS
^FO415,209^A0N,20,20^FD<xsl:value-of select="$cAddress2"/>^FS
^FO415,231^A0N,20,20^FD<xsl:value-of select="$cAddress3"/>^FS
^FO415,253^A0N,20,20^FD<xsl:value-of select="$cAddress4"/>^FS
^FO25,280^GB690,0,2^FS
^FO225,285^A0N,24,24^FDDeliver To^FS
^FO650,285^A0N,24,24^FDEz.R^FS
^FO225,321^A0N,44,28^FD<xsl:value-of select="$dCompany"/>^FS
^FO225,367^A0N,44,28^FD<xsl:value-of select="$dAddress1"/>^FS
^FO225,413^A0N,44,28^FD<xsl:value-of select="$dAddress2"/>^FS
^FO225,459^A0N,44,28^FD<xsl:value-of select="$dAddress3"/>^FS
^FO225,506^A0N,44,28^FD<xsl:value-of select="$dAddress4"/>^FS
^FO225,553^A0N,44,28^FD<xsl:value-of select="$dCounty"/>^FS
^FO225,615^A0N,72,64^FD<xsl:value-of select="$dPostcode"/>^FS
^FO225,700^A0N,24,24^FDTel:^FS
^FO270,685^A0N,44,36^FD<xsl:value-of select="$dTelephone"/>^FS
^LRY^FO650,615^GB63,0,40^FS
^FO655,620^A0N,40,32^FDRPO^FS
^LRN^FO650,560^GB0,170,2^FS
^LRY^FO650,425^GB63,0,40^FS
^FO665,430^A0N,40,32^FDT/L^FS
^LRN^FO650,465^GB0,55,2^FS
^FO665,470^A0N,52,52^FD-^FS
^LRY^FO650,520^GB63,0,40^FS
^FO658,525^A0N,40,32^FDALT^FS
^FO655,575^A0N,40,32^FD - ^FS
^FO220,280^GB0,450,2^FS
^FO35,290^A0N,64,64^SN<xsl:value-of select="$itemNo"/>,1,Y^FS
^FO80,345^A0N,36,36^FDof^FS
^FO110,345^A0N,64,64^FD<xsl:value-of select="$totalItem"/>^FS

^FO35,460^A0N,24,24^FDTotal Weight Kg^FS
^FO35,485^A0N,64,64^FD<xsl:value-of select="$weight"/>^FS
^FO35,545^A0N,24,24^FDDespatched^FS
^FO35,570^A0N,36,52^FD<xsl:value-of select="$despatchDate"/>^FS
^FO25,605^GB195,0,2^FS
^FO35,610^A0N,28,48^FDTuffnells^FS
^FO35,635^A0N,18,26^FDParcels Express^FS
^FO45,650^A0N,20,30^FD^FS
^FO70,675^A0N,18,30^FD<xsl:value-of select="$accountNo"/>^FS
^FO35,695^A0N,36,52^FD<xsl:value-of select="$deliveryDepotNumber"/>/<xsl:value-of select="$deliveryRound"/>^FS
^FO25,730^GB690,0,2^FS
^FO35,735^A0N,35,30^FD<xsl:value-of select="$specialInstruction" />^FS
^FO725,80^BY4^BCB,50,Y,N,N,A^SN<xsl:value-of select="$barcode" />,1,Y^FS
^FO60,830^BY4^BCN,150,Y,N,N,A^SN<xsl:value-of select="$barcode" />,1,Y^FS
^PQ1,0,1
^XZ
</xsl:template>
</xsl:stylesheet>
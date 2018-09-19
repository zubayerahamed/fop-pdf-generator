<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

	<xsl:template match="dxfreight">
		<xsl:call-template name="LABEL"></xsl:call-template>
	</xsl:template>

	<xsl:template name="LABEL">
		<xsl:variable name="DXSERVICENAME"> <xsl:value-of select="/dxfreight/serviceDescription"/> </xsl:variable>
		<xsl:variable name="DXSERVICECODE"> <xsl:value-of select="/dxfreight/serviceCode"/> </xsl:variable>
		<xsl:variable name="totalItem"> <xsl:value-of select="/dxfreight/totalItem"/> </xsl:variable>
		<xsl:variable name="serviceCode"> <xsl:value-of select="/dxfreight/serviceCode"/> </xsl:variable>
		<xsl:variable name="consignmentNumber"> <xsl:value-of select="/dxfreight/consignmentNumber"/> </xsl:variable>
		<xsl:variable name="trackingNumber"> <xsl:value-of select="/dxfreight/trackingNumber"/> </xsl:variable>
		<xsl:variable name="manifestDate"> <xsl:value-of select="/dxfreight/manifestDate"/> </xsl:variable>
		<xsl:variable name="deliveryName"> <xsl:value-of select="/dxfreight/deliveryName"/> </xsl:variable>
		<xsl:variable name="address1"> <xsl:value-of select="/dxfreight/deliveryAddress1"/> </xsl:variable>
		<xsl:variable name="address2"> <xsl:value-of select="/dxfreight/deliveryAddress2"/> </xsl:variable>
		<xsl:variable name="address3"> <xsl:value-of select="/dxfreight/deliveryAddress3"/> </xsl:variable>
		<xsl:variable name="town"> <xsl:value-of select="/dxfreight/deliveryTown"/> </xsl:variable>
		<xsl:variable name="county"> <xsl:value-of select="/dxfreight/deliveryCounty"/> </xsl:variable>
		<xsl:variable name="postcode"> <xsl:value-of select="/dxfreight/deliveryPostCode"/> </xsl:variable>
		<xsl:variable name="serviceCentre"> <xsl:value-of select="/dxfreight/deliveryServiceCentre"/> </xsl:variable>
		<xsl:variable name="depot"> <xsl:value-of select="/dxfreight/origServiceCentre"/> </xsl:variable>
		<xsl:variable name="hub"> <xsl:value-of select="/dxfreight/hubCode"/> </xsl:variable>
		<xsl:variable name="itemNo"> <xsl:value-of select="/dxfreight/itemCount"/> </xsl:variable>
		<xsl:variable name="weight"> <xsl:value-of select="/dxfreight/contentTotalWeight"/> </xsl:variable>
		<xsl:variable name="hawb"> <xsl:value-of select="/dxfreight/consignmentReference1"/> </xsl:variable>
		<xsl:variable name="cref"> <xsl:value-of select="/dxfreight/clientReference"/> </xsl:variable>
		<xsl:variable name="content"> <xsl:value-of select="/dxfreight/contentDescription"/> </xsl:variable>
		<xsl:variable name="customerName"> <xsl:value-of select="/dxfreight/customerName"/> </xsl:variable>
	
<xsl:if test="$DXSERVICECODE != 'THREE DAY'">
//Starting...
^XA
^FO0,1085^A1I,110,68^FB760,1,0,C^FD<xsl:value-of select="$DXSERVICECODE"/>^FS	

//Top section
^CFA,90,25
^FWR
^FO692,40^FD<xsl:value-of select="$DXSERVICENAME"/>^FS
^CFA,48,16
^FO650,40^FDCON NUM: <xsl:value-of select="$consignmentNumber"/> ^FS
^FO605,40^FDDATE: <xsl:value-of select="$manifestDate"/> ^FS

//Barcode
^FO700,400^BY4^BCR,80
^FD<xsl:value-of select="$trackingNumber"/>^FS
^BY2,5,85^FT180,785^BCN,,N,N
^FD>:<xsl:value-of select="$trackingNumber"/>^FS

//Address section
^CFA,40,16
^FO550,40^FB510^FD<xsl:value-of select="$deliveryName"/> ^FS
^FO510,40^FB510^FD<xsl:value-of select="$address1"/>^FS
^FO430,40^FB510,2^FD<xsl:value-of select="$address2"/>^FS
^FO350,40^FB510,2^FD<xsl:value-of select="$address3"/>^FS
^FO270,40^FB510,2^FD<xsl:value-of select="$town"/>^FS
^FO235,40^FB510^FD<xsl:value-of select="$county"/>^FS
^FO195,40^FB510^FDITEM : <xsl:value-of select="$itemNo"/> OF <xsl:value-of select="$totalItem"/>^FS
^FO158,40^FB510^FDWEIGHT : <xsl:value-of select="$weight"/> Kg^FS
^FO120,40^FB510^FDREF : <xsl:value-of select="$hawb"/>^FS
^FO85,40^FB510^FD<xsl:value-of select="$content"/>^FS
^FO90,875^FD<xsl:value-of select="$postcode"/>^FS

//Graphics table
^FO30,30^GB750,0,3^FS
^FO30,1085^GB750,0,3^FS
^FO595,30^GB0,1055,3^FS
^FO80,30^GB0,1055,3^FS
^FO80,550^GB515,0,3^FS
^FO80,700^GB515,0,3^FS
^FO475,625^GB120,0,1^FS

//Middle black-box
^LRY^FO240,553^GB235,0,147^FS^LRN

//Right section
^CFA,48,16
^FO540,875^FDEX : <xsl:value-of select="$depot"/>^FS
^FT200,820^A0I,400,235^FH\^FWR^FD<xsl:value-of select="$serviceCentre"/>^FS

//Hub code section
^FT110,585^A0I,150,145^FH\^FWR^FD<xsl:value-of select="$hub"/>^FS

//Lower section
^CFA,48,16
^FO30,40^FD<xsl:value-of select="$customerName"/>^FS
^CFA,25,8
^FO50,635^FD<xsl:value-of select="$cref"/>^FS

^XZ
//Ending...
</xsl:if>


<xsl:if test="$DXSERVICECODE = 'THREE DAY'">
//Starting...
^XA
^FO0,05^A1I,110,68^FB760,1,0,C^FD<xsl:value-of select="$DXSERVICECODE"/>^FS 

//Top section
^CFA,90,25
^FWR
^FO692,140^FD<xsl:value-of select="$DXSERVICENAME"/>^FS

^CFA,48,16
^FO650,140^FDCON NUM: <xsl:value-of select="$consignmentNumber"/>^FS
^FO605,140^FDDATE: <xsl:value-of select="$manifestDate"/>^FS

//Barcode
^FO700,500^BY4^BCR,80
^FD<xsl:value-of select="$trackingNumber"/>^FS
^BY2,5,85^FT180,885^BCN,,N,N
^FD>:<xsl:value-of select="$trackingNumber"/>^FS

//Address section
^CFA,40,16
^FO550,140^FB510^FD<xsl:value-of select="$deliveryName"/> ^FS
^FO510,140^FB510^FD<xsl:value-of select="$address1"/>^FS
^FO430,140^FB510,2^FD<xsl:value-of select="$address2"/>^FS
^FO350,140^FB510,2^FD<xsl:value-of select="$address3"/>^FS
^FO270,140^FB510,2^FD<xsl:value-of select="$town"/>^FS
^FO235,140^FB510^FD<xsl:value-of select="$county"/>^FS
^FO195,140^FB510^FDITEM : <xsl:value-of select="$itemNo"/> OF <xsl:value-of select="$totalItem"/>^FS
^FO158,140^FB510^FDWEIGHT : <xsl:value-of select="$weight"/> Kg^FS
^FO120,140^FB510^FDREF : <xsl:value-of select="$hawb"/>^FS
^FO85,140^FB510^FD<xsl:value-of select="$content"/>^FS
^FO90,975^FD<xsl:value-of select="$postcode"/>^FS

//Graphics table
^FO30,130^GB750,0,3^FS
^FO30,1185^GB750,0,3^FS
^FO595,130^GB0,1055,3^FS
^FO80,130^GB0,1055,3^FS
^FO80,650^GB515,0,3^FS
^FO80,800^GB515,0,3^FS
^FO475,725^GB120,0,1^FS

//Middle white-box
^LRY^FO240,653^GB0,146,3^FS^LRN
^LRY^FO472,653^GB0,146,3^FS^LRN

//Right section
^CFA,48,16
^FO540,975^FDEX : <xsl:value-of select="$depot"/>^FS
^FT200,920^A0I,400,235^FH\^FWR^FD<xsl:value-of select="$serviceCentre"/>^FS

//Hub code section
^FT110,685^A0I,150,145^FH\^FWR^FD<xsl:value-of select="$hub"/>^FS

//Lower section
^CFA,48,16
^FO30,140^FD<xsl:value-of select="$customerName"/>^FS
^CFA,25,8
^FO50,735^FD<xsl:value-of select="$cref"/>^FS

^XZ
//Ending...
</xsl:if>

	</xsl:template>
</xsl:stylesheet>
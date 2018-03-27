<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!--!                                                              !-->
<!--!    File Name    : bluesky_hawb_template.xsl                  !-->
<!--!    Description  : Bluesky AWB template (customized)          !-->
<!--!    Author       : Ahsan                                      !-->
<!--!    Date         : 11-Feb-2015                                !-->
<!--!    Copyright    : Copyright (c) M.F. Systems, 2015           !-->
<!--!                                                              !-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="com.metafour.netcourier.util.FopHelper" extension-element-prefixes="java">
    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>
    <!-- ========================= -->
    <!-- root element: statement   -->
    <!-- ========================= -->
    <xsl:template match="netc">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
		
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" page-height="29.02cm" page-width="21cm" margin-top="4mm" margin-bottom="0mm" margin-left="6mm" margin-right="5mm">
                    <fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="0mm"/>
                    <fo:region-before extent="0mm"/>
                    <fo:region-after extent="0mm"/>
                </fo:simple-page-master>
				
                <fo:page-sequence-master master-name="document">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference page-position="first" master-reference="A4"/>
                        <fo:conditional-page-master-reference page-position="rest" master-reference="A4"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
			
            <fo:page-sequence master-reference="document">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container height="145mm" width="21cm" left="0mm" top="0mm" position="absolute">
                        <xsl:call-template name="hawb"/>
                    </fo:block-container>
                    <fo:block-container height="145mm" width="21cm" left="0mm" top="147.75mm" position="absolute">
                        <xsl:call-template name="hawb"/>
                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>

        </fo:root>
    </xsl:template>


    <xsl:template name="hawb">

        <fo:block-container height="27mm" width="32mm" left="0mm" top="1.7mm" position="absolute">
            <xsl:call-template name="logo"/>
        </fo:block-container>

        <fo:block-container height="26mm" width="24mm" left="100mm" top="2mm" position="absolute">
            <xsl:call-template name="item_info"/>
        </fo:block-container>

        <fo:block-container height="26mm" width="32mm" left="67mm" top="2mm" position="absolute">
            <xsl:call-template name="date"/>
        </fo:block-container>
		
        <fo:block-container height="26mm" width="74mm" left="125mm" top="2mm" position="absolute">
            <xsl:call-template name="awb_info"/>
        </fo:block-container>

        <fo:block-container height="50mm" width="99mm" left="0mm" top="31mm" position="absolute">
            <xsl:call-template name="shipper"/>
        </fo:block-container>

        <fo:block-container height="50mm" width="99mm" left="100mm" top="31mm" position="absolute">
            <xsl:call-template name="consignee"/>
        </fo:block-container>

        <fo:block-container height="20mm" width="99mm" left="100mm" top="85mm" position="absolute">
            <xsl:call-template name="sdi"/>
        </fo:block-container>

        <fo:block-container height="20mm" width="36mm" left="63mm" top="85mm" position="absolute">
            <xsl:call-template name="vfc"/>
        </fo:block-container>

        <fo:block-container height="26mm" width="62mm" left="0mm" top="85mm" position="absolute">
            <xsl:call-template name="doc"/>
        </fo:block-container>

        <fo:block-container height="26mm" width="199mm" left="0mm" top="103mm" position="absolute">
            <xsl:call-template name="received"/>
        </fo:block-container>

        <fo:block-container height="26mm" width="199mm" left="0mm" top="128mm" position="absolute">
            <xsl:call-template name="ft"/>
        </fo:block-container>
    
    </xsl:template>

  
  
    <xsl:template name="logo">
        <fo:block>
            <xsl:variable name="imagepath" select="concat('file:',/netc/hawb/image_path,'ecourieruk_logo.jpg')"/>
            <fo:external-graphic padding="0" margin="0" space-start="0" space-end="0" pause-before="0" pause-after="0" content-height="12mm" content-width="35mm" scaling="non-uniform" src="{$imagepath}"/>
        </fo:block>
    </xsl:template>

    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- ! Template name   : barcode (Barcode generator)                                      ! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- ! Parameters used:                                                                   ! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- ! awbn                : number                                                       ! -->
    <!-- ! StartSoop value     : true/false                                                   ! -->
    <!-- ! humanReadable value : true/false                                                   ! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- ! Example                                                                            ! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- ! <xsl:call-template name="barcode">                                                 ! -->                                                                               
    <!-- !   <xsl:with-param name="awbn">123456</xsl:with-param>                              ! -->
    <!-- !   <xsl:with-param name="startStop">true</xsl:with-param>                           ! -->
    <!-- !   <xsl:with-param name="humanReadable">true</xsl:with-param>                       ! -->
    <!-- ! </xsl:call-template>                                                               ! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

    <xsl:template name="barcode"> 
        <xsl:param name="awbn"/>  
        <xsl:param name="startStop"/>
        <xsl:param name="humanReadable"/>
        <xsl:param name="barcodeHeight"/>
        <fo:block>
            <fo:instream-foreign-object>
                <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$awbn}">
                    <barcode:code39>
                        <barcode:height>
                            <xsl:value-of select="$barcodeHeight"/>mm</barcode:height>
                        <barcode:module-width>0.30mm</barcode:module-width>
                        <xsl:if test="$humanReadable != 'true'">
                            <barcode:human-readable>none</barcode:human-readable>
                        </xsl:if>  
                        <barcode:human-readable>
                            <barcode:display-start-stop>
                                <xsl:value-of select="$startStop"/>
                            </barcode:display-start-stop>
                            <font-size>18pt</font-size>
                        </barcode:human-readable>
                    </barcode:code39>
                </barcode:barcode>      
            </fo:instream-foreign-object>
        </fo:block>
    </xsl:template>
	
	
	
    <xsl:template name="title">
        <!--<fo:block font-size="8pt" margin-right="0" padding="0" text-align="left">		
E-mail: info@swisspostsolutions.com
        </fo:block>-->
		
        <fo:block font-size="8pt" margin-right="0" padding="0" text-align="left">		
            Web: www.blueskyglobal.biz
        </fo:block>
    </xsl:template>
	
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- !!         awb_info    !! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	
    <xsl:template name="awb_info">
        <fo:table font-weight="bold" font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="74mm"/>
            <fo:table-body>
                <fo:table-row height="4mm" xsl:use-attribute-sets="text.header">
                    <fo:table-cell>
                        <fo:block>TRACKING NO.</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="22mm">
                    <fo:table-cell xsl:use-attribute-sets="border.top">
                        <fo:block text-align="center" space-before.optimum="6pt">                
                            <xsl:call-template name="barcode">
                                <xsl:with-param name="awbn">
                                    <xsl:value-of select="/netc/hawb/cs_awbn"/>
                                </xsl:with-param>
                                <xsl:with-param name="startStop">false</xsl:with-param>
                                <xsl:with-param name="humanReadable">true</xsl:with-param>
                                <xsl:with-param name="barcodeHeight">15</xsl:with-param>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>  
    </xsl:template>

    <xsl:template name="item_info">
        <fo:table font-weight="bold" font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="24mm"/>
            <fo:table-body>
                <fo:table-row height="4mm" background-color="#D4C1FF" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>PIECES</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="9mm" background-color="#FFFFFE" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>1</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="4mm" background-color="#D4C1FF" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>WEIGHT</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="9mm" background-color="#FFFFFE" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>1.00 Kgs</fo:block>
                    </fo:table-cell>
                </fo:table-row>			
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="date">
        <fo:table font-weight="bold" font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="32mm"/>
            <fo:table-body>
                <fo:table-row height="4mm" background-color="#D4C1FF" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>DATE</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="9mm" background-color="#FFFFFE" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="hawb/cs_bkdt"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="4mm" background-color="#D4C1FF" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>ACCOUNT NUMBER</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="9mm" background-color="#FFFFFE" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="hawb/ac_number"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>			
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="shipper">
        <fo:table font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="50mm"/>
            <fo:table-column column-width="49mm"/>
            <fo:table-body>
                <fo:table-row height="5mm" margin-left="1mm" background-color="#D4C1FF" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block font-weight="bold">SHIPPER</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="5mm" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell column-width="50">
                        <fo:block>FROM : <xsl:value-of select="hawb/da_ctnm"/></fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>SHIPPER REF : <xsl:value-of select="hawb/cs_cref"/></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="29mm" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="hawb/cl_desc"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/cl_adr1"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/cl_adr2"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/cl_adr4"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/cl_decd"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/cl_co_desc"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="11mm" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>PHONE NUMBER : <xsl:value-of select="hawb/cl_phon"/></fo:block>
                    </fo:table-cell>
                </fo:table-row>			
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="consignee">
        <fo:table font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="99mm"/>
            <fo:table-body>
                <fo:table-row height="5mm" background-color="#D4C1FF" border="1pt solid black" margin-left="1mm">
                    <fo:table-cell>
                        <fo:block font-weight="bold">CONSIGNEE</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="5mm" background-color="#FFFFFE" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>TO : <xsl:value-of select="hawb/da_ctnm"/></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="29mm" background-color="#FFFFFE" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="hawb/da_cnam"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/da_adr1"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/da_adr2"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/da_zpcd"/>
                        </fo:block>
                        <fo:block>
                            <xsl:value-of select="hawb/da_co_desc"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="11mm" background-color="#FFFFFE" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block font-size="5pt">P.O. BOX ADDRESSES WILL REQUIRE RECIPIENT'S PHONE NUMBER</fo:block>
                        <fo:block>PHONE NUMBER : <xsl:value-of select="hawb/da_phon"/></fo:block>
                    </fo:table-cell>
                </fo:table-row>			
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="sdi">
        <fo:table font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="99mm"/>
            <fo:table-body>
                <fo:table-row height="5mm" background-color="#D4C1FF" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block font-weight="bold">SPECIAL DELIVERY INSTRUCTIONS</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="11mm" background-color="#FFFFFE" border="1pt solid black" margin-left="1mm">
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="hawb/cs_note"/>
                        </fo:block>
                        <fo:block>Service Level : <xsl:value-of select="hawb/sl_desc"/></fo:block>
                    </fo:table-cell>
                </fo:table-row>		
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="vfc">
        <fo:table font-weight="bold" font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="text.box">
            <fo:table-column column-width="36mm"/>
            <fo:table-body>
                <fo:table-row height="5mm" background-color="#D4C1FF" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block>VALUE FOR CUSTOMS</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="11mm" background-color="#FFFFFE" text-align="center" border="1pt solid black">
                    <fo:table-cell>
                        <fo:block></fo:block>
                    </fo:table-cell>
                </fo:table-row>		
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="doc">
        <fo:table font-weight="bold" font-size="8pt" padding="0pt" table-layout="fixed" background-color="#D4C1FF">
            <fo:table-column column-width="62mm"/>
            <fo:table-body>
                <fo:table-row height="10mm" margin-left="1mm" margin-top="1pt">
                    <fo:table-cell>
                        <fo:block margin-top="1mm">DESCRIPTION OF CONTENTS</fo:block>
                        <fo:block font-size="3pt" margin-top="2mm">5 COPIES OF PROFORMA INVOICE REQUIRED FOR NON-DOCUMENT SHIPMENTS OUTSIDE OF EU</fo:block>	
                        <fo:block margin-top="2mm" margin-bottom="4mm">
                            <xsl:value-of select="hawb/contentsType"/>
                        </fo:block>				
                    </fo:table-cell>
                </fo:table-row>	
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="received">
        <fo:table font-size="8pt" padding="0pt" table-layout="fixed" xsl:use-attribute-sets="cell.element">
            <fo:table-column column-width="62mm"/>
            <fo:table-column column-width="62mm"/>
            <fo:table-column column-width="38mm"/>
            <fo:table-column column-width="37mm"/>
            <fo:table-body>
                <fo:table-row height="5mm" background-color="#D4C1FF" margin-left="1mm" border="1pt solid black">
                    <fo:table-cell font-weight="bold" display-align="center">
                        <fo:block>RECEIVED BY:</fo:block>
                    </fo:table-cell>
                    <fo:table-cell background-color="#D4C1FF">
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell background-color="#D4C1FF">
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell background-color="#D4C1FF">
                        <fo:block></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row height="18mm" background-color="#FFFFFE" border="1pt solid black">
                    <fo:table-cell border="1pt solid black" margin-left="1mm">
                        <fo:block>SIGN: </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="1pt solid black" margin-top="2mm" margin-left="1mm">
                        <fo:block>PRINT NAME: </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="1pt solid black" margin-left="1mm" margin-top="1mm">
                        <fo:block>DATE: </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="1pt solid black" margin-left="1mm" margin-top="1mm">
                        <fo:block>TIME: </fo:block>
                    </fo:table-cell>
                </fo:table-row>		
            </fo:table-body>
        </fo:table>    
    </xsl:template>

    <xsl:template name="ft">
        <fo:block text-align="center" font-size="7pt">THIS IS A NON-NEGOTIABLE AWB ISSUED SUBJECT TO THE COMPANY'S STANDARD TRADING CONDITIONS, A COPY OF WHICH IS AVAILABLE ON REQUEST.</fo:block>
    </xsl:template>

  

    <!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
    <!--!         Attribute set / CSS              !-->
    <!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
  
    <xsl:attribute-set name="text.box">
        <xsl:attribute name="font-size">7pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>    
        <xsl:attribute name="display-align">center</xsl:attribute>
        <xsl:attribute name="padding">2px</xsl:attribute>
        <xsl:attribute name="border">1px solid #000000</xsl:attribute>
    </xsl:attribute-set>
  
    <xsl:attribute-set name="text.header">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>        
        <xsl:attribute name="background-color">#D4C1FF</xsl:attribute>
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="border.rightWhite">
        <xsl:attribute name="border-right">1px solid #000000</xsl:attribute>    
    </xsl:attribute-set>
  
    <xsl:attribute-set name="border.right">
        <xsl:attribute name="border-right">1px solid #000000</xsl:attribute>    
    </xsl:attribute-set>

    <xsl:attribute-set name="border.top">
        <xsl:attribute name="border-top">1px solid #000000</xsl:attribute>    
    </xsl:attribute-set>
  
    <xsl:attribute-set name="border.left">
        <xsl:attribute name="border-left">1px solid #000000</xsl:attribute>    
    </xsl:attribute-set>
	
    <xsl:attribute-set name="border.bottom">
        <xsl:attribute name="border-bottom">1px solid #000000</xsl:attribute>    
    </xsl:attribute-set>
	
    <xsl:attribute-set name="border.all">
        <xsl:attribute name="border">1px solid #000000</xsl:attribute>    
    </xsl:attribute-set>

    <xsl:attribute-set name="cell.element">
        <xsl:attribute name="font-size">7pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="padding">2px</xsl:attribute>
        <xsl:attribute name="border">1px solid #000000</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>

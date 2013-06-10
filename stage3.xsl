<?xml version="1.0" encoding="koi8-r"?>
<xsl:stylesheet version = '1.0'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
    xmlns:slim="http://www.loc.gov/MARC21/slim"
    xmlns:date="http://exslt.org/dates-and-times"
     exclude-result-prefixes="slim date"
     extension-element-prefixes="date">
     <xsl:output method="xml"  encoding="koi8-r"
	  indent="yes"/>

<xsl:template match="/">
    <xsl:element name="output">
    <xsl:if test="//terminate_now">
	<xsl:message terminate="yes"></xsl:message>
    </xsl:if>
    <xsl:if test="not(//out)">
	<xsl:message terminate="yes"></xsl:message>
    </xsl:if>
	<xsl:apply-templates select="//output/*" />
    </xsl:element>
</xsl:template>



<xsl:template match="id_a|id_b">
    <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="out">
<xsl:element name="out">
    <xsl:choose>
	<xsl:when test=".='yes'">
	    <xsl:text>2</xsl:text>
	</xsl:when>
	<xsl:when test=".='no'">
	    <xsl:text>1</xsl:text>
	</xsl:when>
    </xsl:choose>
</xsl:element>
</xsl:template>

<xsl:template match="birth[1]|death[1]">
<xsl:element name="{name()}">
    <xsl:choose>
	<xsl:when test=".='yes'">
	    <xsl:text>3</xsl:text>
	</xsl:when>
	<xsl:when test=".='not defined'">
	    <xsl:text>2</xsl:text>
	</xsl:when>
	<xsl:when test=".='no'">
	    <xsl:text>1</xsl:text>
	</xsl:when>
    </xsl:choose>
</xsl:element>
</xsl:template>


<xsl:template match="//output/*[contains(name(),'about_')]">
    <xsl:variable name="paramname"><xsl:value-of select="substring-after(name(.),'about_')" /></xsl:variable>
    <xsl:if test="$paramname != ''">
	    <xsl:apply-templates select="k1|k2">
		<xsl:with-param name="paramname" select="$paramname" />
	    </xsl:apply-templates>
    </xsl:if>
</xsl:template>
<xsl:template match="k1[.='not defined']">
<xsl:param name="paramname" />
    <xsl:element name="{concat($paramname,'_1')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_k1')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_n1')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_part1')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="k2[.='not defined']">
<xsl:param name="paramname" />
    <xsl:element name="{concat($paramname,'_2')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_k2')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_n2')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_part2')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_num2')}">
	<xsl:text>2</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="k1[.!='not defined' and .= 0]">
<xsl:param name="paramname" />
    <xsl:element name="{concat($paramname,'_1')}">
    	<xsl:text>1</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_k1')}">
    	<xsl:text>1</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_n1')}">
	<xsl:value-of select="../n1 + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_part1')}">
    	<xsl:text>1</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="k1[.!='not defined' and .> 0]">
<xsl:param name="paramname" />
    <xsl:element name="{concat($paramname,'_1')}">
    	<xsl:text>3</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_k1')}">
	<xsl:value-of select=". + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_n1')}">
	<xsl:value-of select="../n1 + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_part1')}">
	<xsl:value-of select=". div ../n1 + 2" />
    </xsl:element>
    
</xsl:template>

<xsl:template match="k2[.!='not defined' and .= 0]">
<xsl:param name="paramname" />
    <xsl:element name="{concat($paramname,'_2')}">
	<xsl:text>1</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_k2')}">
	<xsl:text>1</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_n2')}">
	<xsl:value-of select="../n2 + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_part2')}">
	<xsl:text>1</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_num2')}">
	<xsl:value-of select="../num2 + 2" />
    </xsl:element>
</xsl:template>


<xsl:template match="k2[.!='not defined' and .> 0]">
<xsl:param name="paramname" />
    <xsl:element name="{concat($paramname,'_2')}">
    	<xsl:text>3</xsl:text>
    </xsl:element>
    <xsl:element name="{concat($paramname,'_k2')}">
	<xsl:value-of select=". + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_n2')}">
	<xsl:value-of select="../n2 + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_part2')}">
	<xsl:value-of select=". div ../n2 + 2" />
    </xsl:element>
    <xsl:element name="{concat($paramname,'_num2')}">
	<xsl:value-of select="../num2 + 2" />
    </xsl:element>
</xsl:template>

<xsl:template match="*">
    <zagl>
	<xsl:copy-of select="." />
    </zagl>
</xsl:template>
</xsl:stylesheet>

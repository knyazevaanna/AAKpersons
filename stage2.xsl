<?xml version="1.0" encoding="koi8-r"?>
<xsl:stylesheet version = '1.0'
    xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:date="http://exslt.org/dates-and-times"
     exclude-result-prefixes="marc date"
     extension-element-prefixes="date">
     <xsl:output method="xml"  encoding="koi8-r"
	  indent="yes"/>

    <xsl:variable name="author" select="//a"/>
    <xsl:param name="surnameA"><xsl:value-of select="normalize-space(//a//marc:datafield[@tag=200]/marc:subfield[@code='a'])"/></xsl:param>
    <xsl:param name="initA"><xsl:value-of select="normalize-space(//a//marc:datafield[@tag=200]/marc:subfield[@code='b'])"/></xsl:param>


<xsl:template match="/">
    <output>
	<xsl:if test="not(//a//marc:datafield[@tag='200']/marc:subfield[@code='c'])">
	    <xsl:element name='terminate_now'/>
	    <xsl:message terminate="yes"><xsl:text>No field $c in author record!!!</xsl:text></xsl:message>    
	</xsl:if>
	<xsl:if test="not(//a//marc:datafield[@tag='200']/marc:subfield[@code='f'])">
	    <xsl:element name='terminate_now'/>
	    <xsl:message terminate="yes"><xsl:text>No field $f in author record!!!</xsl:text></xsl:message>    
	</xsl:if>
	<xsl:if test="not(//a//marc:datafield[@tag='200']/marc:subfield[@code='y'])">
	    <xsl:element name='terminate_now'/>
	    <xsl:message terminate="yes"><xsl:text>No field $y in author record!!!</xsl:text></xsl:message>    
	</xsl:if>
	<xsl:if test="not(//a//marc:controlfield[@tag='001'])">
	    <xsl:element name='terminate_now'/>
	    <xsl:message terminate="yes"><xsl:text>No ID  in author record!!!</xsl:text></xsl:message>    
	</xsl:if>
	<xsl:if test="not(//b//marc:controlfield[@tag='001'])">
	    <xsl:element name='terminate_now'/>
	    <xsl:message terminate="yes"><xsl:text>No ID  in biblio record!!!</xsl:text></xsl:message>    
	</xsl:if>
	<xsl:if test="//b//marc:controlfield[@tag='001']=''">
	    <xsl:element name='terminate_now'/>
	    <xsl:message terminate="yes"><xsl:text>No ID  in biblio record!!!</xsl:text></xsl:message>    
	</xsl:if>
<!--group -->
	<xsl:element name="about_group">
	<xsl:choose>
	    <xsl:when test="not(//b//marc:datafield[@tag='712']/marc:subfield[@code='a'])">
		<k1>not defined</k1>
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='group2']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n1">
		<xsl:value-of select="count(//search_response[@name='group1'])" />
	    </xsl:element>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='group2'])" />
	    </xsl:element>
	    <xsl:element name="k1">
		<xsl:value-of select="count(//search_response[@name='group1' and .>0])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='group2' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!--place -->
	<xsl:element name="about_place">
	<xsl:choose>
	    <xsl:when test="not(//b//marc:datafield[@tag='712']/marc:subfield[@code='c'])">
		<k1>not defined</k1>
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='place2']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n1">
		<xsl:value-of select="count(//search_response[@name='place1'])" />
	    </xsl:element>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='place2'])" />
	    </xsl:element>
	    <xsl:element name="k1">
		<xsl:value-of select="count(//search_response[@name='place1' and .>0])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='place2' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!--coauthor -->
	<xsl:element name="about_coauthor">
	<xsl:choose>
	    <xsl:when test="not(//search_response[@name='coauthor'])">
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='coauthor']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='coauthor'])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='coauthor' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!--coauthor_id -->
	<xsl:element name="about_coauthor_id">
	<xsl:choose>
	    <xsl:when test="not(//search_response[@name='coauthor_id'])">
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='coauthor_id']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='coauthor_id'])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='coauthor_id' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!--subject -->
	<xsl:element name="about_subject">
	<xsl:choose>
	    <xsl:when test="not(//search_response[@name='subject'])">
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='subject']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='subject'])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='subject' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!--subject_id -->
	<xsl:element name="about_subject_id">
	<xsl:choose>
	    <xsl:when test="not(//search_response[@name='subject_id'])">
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='subject_id']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='subject_id'])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='subject_id' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!--IDies -->
    <xsl:element name="id_a">
	<xsl:value-of select="//a//marc:controlfield[@tag='001']" />
    </xsl:element>
    <xsl:element name="id_b">
        <xsl:value-of select="//b//marc:controlfield[@tag='001']" />
    </xsl:element>
	<xsl:apply-templates select="//b//marc:datafield[@tag='700'] | //b//marc:datafield[@tag='701'] | //b//marc:datafield[@tag='702']"/>
	<xsl:apply-templates select="//search_response" />
    </output>
</xsl:template>

<xsl:template match="marc:datafield[@tag='700'] | marc:datafield[@tag='701'] | marc:datafield[@tag='702']">
    <xsl:if test="normalize-space(./marc:subfield[@code='a'])=$surnameA">
	<xsl:if test="normalize-space(./marc:subfield[@code='b'])=$initA">
	    <xsl:if test="not(./marc:subfield[@code='3'])">
		<xsl:element name='terminate_now'/>
		<xsl:message terminate="yes"><xsl:text>No field $3 in biblio record!!!</xsl:text></xsl:message>    
	    </xsl:if>
<!-- out  -->
	    <xsl:element name="out">
		<xsl:choose>
		    <xsl:when test="./marc:subfield[@code='3']=//a//marc:controlfield[@tag='001']">
			<xsl:text>yes</xsl:text>
		    </xsl:when>
		    <xsl:otherwise>
			<xsl:text>no</xsl:text>
		    </xsl:otherwise>
		</xsl:choose>
	    </xsl:element>
<!-- birth  -->
	    <xsl:variable name="birthdateA" select="substring(//a//marc:datafield[@tag='200']/marc:subfield[@code='f'],1,4)"/>
	    <xsl:variable name="birthdateB" select="substring(./marc:subfield[@code='f'],1,4)"/>
	    <xsl:element name="birth">
		<xsl:if test="not($birthdateB)">
		    <xsl:text>not defined</xsl:text>
		</xsl:if>
		<xsl:if test="$birthdateB">
		    <xsl:choose>
			<xsl:when test="$birthdateB=$birthdateA">
			    <xsl:text>yes</xsl:text>
			</xsl:when>
			<xsl:otherwise>
			    <xsl:text>no</xsl:text>
			</xsl:otherwise>
		    </xsl:choose>
		</xsl:if>
	    </xsl:element>
<!-- death  -->
	    <xsl:variable name="deathdateA" select="substring-after(//a//marc:datafield[@tag='200']/marc:subfield[@code='f'],'-')"/>
	    <xsl:variable name="deathdateB" select="substring-after(./marc:subfield[@code='f'],'-')"/>
	    <xsl:element name="death">
		<xsl:if test="(not($deathdateA)) or (not($deathdateB))">
		    <xsl:text>not defined</xsl:text>
		</xsl:if>
		<xsl:if test="($deathdateB) and ($deathdateA)">
		<xsl:choose>
		    <xsl:when test="substring($deathdateB,1,4)=substring($deathdateA,1,4)">
			<xsl:text>yes</xsl:text>
		    </xsl:when>
		    <xsl:otherwise>
			<xsl:text>no</xsl:text>
		    </xsl:otherwise>
		</xsl:choose>
		</xsl:if>
	    </xsl:element>
<!-- addition -->
	<xsl:element name="about_addition">
	<xsl:choose>
	    <xsl:when test="not(./marc:subfield[@code='c'])">
		<k1>not defined</k1>
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='addition2']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n1">
		<xsl:value-of select="count(//search_response[@name='addition1'])" />
	    </xsl:element>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='addition2'])" />
	    </xsl:element>
	    <xsl:element name="k1">
		<xsl:value-of select="count(//search_response[@name='addition1' and .>0])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='addition2' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
    </xsl:element>
<!-- work  -->
	<xsl:element name="about_work">
	<xsl:choose>
	    <xsl:when test="(not(./marc:subfield[@code='p']))">
		<k1>not defined</k1>
		<k2>not defined</k2>
	    </xsl:when>
	    <xsl:otherwise>
	    <xsl:for-each select="//search_response[@name='work2']">
	    <xsl:sort data-type="number" order="descending" select="." />
		<xsl:if test="position()=1">    
		<xsl:element name="num2">
		    <xsl:value-of select="." />
		</xsl:element>
		</xsl:if>
	    </xsl:for-each>
	    <xsl:element name="n1">
		<xsl:value-of select="count(//search_response[@name='work1'])" />
	    </xsl:element>
	    <xsl:element name="n2">
		<xsl:value-of select="count(//search_response[@name='work2'])" />
	    </xsl:element>
	    <xsl:element name="k1">
		<xsl:value-of select="count(//search_response[@name='work1' and .>0])" />
	    </xsl:element>
	    <xsl:element name="k2">
		<xsl:value-of select="count(//search_response[@name='work2' and .>0])" />
	    </xsl:element>
	    </xsl:otherwise>
	</xsl:choose>
	</xsl:element>    
    </xsl:if>
</xsl:if>
</xsl:template>


<!--dummy pattern -->
<xsl:template match="*" />
</xsl:stylesheet>

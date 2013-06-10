<?xml version="1.0" encoding="koi8-r"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    exclude-result-prefixes="marc"
    >
    <xsl:output method="xml" />
    <xsl:template match="*|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>

    <!-- Supplements -->
    <xsl:template match="aak">
        <output>
            <xsl:call-template name="search-request"/>
        </output>
    </xsl:template>
    <xsl:template name="search-request">
        <xsl:variable name="id">
            <xsl:value-of select="a/marc:record/marc:controlfield[@tag='001']" />
        </xsl:variable>
        <xsl:variable name="idB">
            <xsl:value-of select="b/marc:record/marc:controlfield[@tag='001']" />
        </xsl:variable>
        <xsl:variable name="surname">
            <xsl:value-of select="normalize-space(a/marc:record/marc:datafield[@tag='200']/marc:subfield[@code='a'])" />
        </xsl:variable>
        <!-- addition1 -->
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='701']|b/marc:record/marc:datafield[@tag='700']">
    	    <xsl:if test="normalize-space(marc:subfield[@code='a'])=$surname">
		<xsl:variable name="dbclass">A</xsl:variable>
        	<xsl:variable name="name">addition1</xsl:variable>
        	<xsl:for-each select="marc:subfield[@code='c']">
        	    <xsl:variable name="term">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="{$name}" dbclass="{$dbclass}">
            		<xsl:value-of select="concat('@and @attr 1=12 {', $id, '} @attr 1=9200 @attr 2=101 {', $term, '}')" />
        	    </search_request>
        	<!--additions from EAR -->
        	    <xsl:variable name="addition2">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="addition2" dbclass="B">
             		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9205 {', $addition2, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
        	</xsl:for-each>
    	    </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='702']">
    	    <xsl:if test="normalize-space(marc:subfield[@code='a'])=$surname">
		<xsl:if test="not(../marc:datafield[@tag='701']/marc:subfield[@code='a' and text()=$surname])">
		<xsl:variable name="dbclass">A</xsl:variable>
        	<xsl:variable name="name">addition1</xsl:variable>
        	<xsl:for-each select="marc:subfield[@code='c']">
        	    <xsl:variable name="term">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="{$name}" dbclass="{$dbclass}">
            		<xsl:value-of select="concat('@and @attr 1=12 {', $id, '} @attr 1=9200 @attr 2=101 {', $term, '}')" />
        	    </search_request>
        	<!--additions from EAR -->
        	    <xsl:variable name="addition2">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="addition2" dbclass="B">
             		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9205 {', $addition2, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
        	</xsl:for-each>
        	</xsl:if>
    	    </xsl:if>
        </xsl:for-each>
        <!-- place1 -->
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='712']/marc:subfield[@code='c']">
            <xsl:variable name="dbclass">A</xsl:variable>
            <xsl:variable name="name">place1</xsl:variable>
            <xsl:variable name="term">
                <xsl:value-of select="." />
            </xsl:variable>
            <search_request name="{$name}" dbclass="{$dbclass}">
                <xsl:value-of select="concat('@and @attr 1=12 {',$id ,'} @attr 1=9201 @attr 2=101 {', $term, '}')" />
            </search_request>
        	<!--place from EAR -->
        	    <xsl:variable name="place2">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="place2" dbclass="B">
             		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9201 {', $place2, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
        </xsl:for-each>
        <!-- work1 -->
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='701']|b/marc:record/marc:datafield[@tag='700']|b/marc:record/marc:datafield[@tag='702']">
    	    <xsl:if test="marc:subfield[@code='a']=$surname">
        	<xsl:variable name="dbclass">A</xsl:variable>
        	<xsl:variable name="name">work1</xsl:variable>
        	<xsl:variable name="term">
            	    <xsl:value-of select="marc:subfield[@code='p']" />
        	</xsl:variable>
        	<search_request name="{$name}" dbclass="{$dbclass}">
            	    <xsl:value-of select="concat('@and @attr 1=12 {', $id, '} @attr 1=9203 @attr 2=101 {', $term, '}')" />
        	</search_request>
        	<!--work from EAR-->
        	    <search_request name="work2" dbclass="B">
             		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9206 {', $term, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
    	    </xsl:if>
        </xsl:for-each>
        <!-- old work2 = group1 -->
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='712']/marc:subfield[@code='a']">
            <xsl:variable name="dbclass">A</xsl:variable>
            <xsl:variable name="name">group1</xsl:variable>
            <xsl:variable name="term">
                <xsl:value-of select="." />
            </xsl:variable>
            <search_request name="{$name}" dbclass="{$dbclass}">
                <xsl:value-of select="concat('@and @attr 1=12 {', $id, '} @attr 1=9204 @attr 2=101 {', $term, '}')" />
            </search_request>
            <!--group author from EAR -->
    	    <search_request name="group2" dbclass="B">
     		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9202 {', $term, '} @attr 1=12 {', $idB, '}')" />
	    </search_request>
        </xsl:for-each>
        <!-- coauthor -->
    	<xsl:for-each select="b/marc:record/marc:datafield[@tag='701']|b/marc:record/marc:datafield[@tag='700']|b/marc:record/marc:datafield[@tag='702']">
    	    <xsl:if test="marc:subfield[@code='a']!=$surname">
		<xsl:variable name="dbclass">B</xsl:variable>
        	<xsl:variable name="name">coauthor</xsl:variable>
        	<xsl:for-each select="marc:subfield[@code='a']">
        	    <xsl:variable name="co_surname">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="{$name}" dbclass="{$dbclass}">
            		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=1003 {', $co_surname, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
        	</xsl:for-each>
    	    </xsl:if>
        </xsl:for-each>
        <!-- coauthor_id -->
    	<xsl:for-each select="b/marc:record/marc:datafield[@tag='701']|b/marc:record/marc:datafield[@tag='700']|b/marc:record/marc:datafield[@tag='702']">
    	    <xsl:if test="marc:subfield[@code='a']!=$surname">
		<xsl:variable name="dbclass">B</xsl:variable>
        	<xsl:variable name="name">coauthor_id</xsl:variable>
        	<xsl:for-each select="marc:subfield[@code='3']">
        	    <xsl:variable name="co_id">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="{$name}" dbclass="{$dbclass}">
            		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9003 {', $co_id, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
        	</xsl:for-each>
    	    </xsl:if>
        </xsl:for-each>
        <!-- keywords -->
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='606' and marc:subfield[@code='8' and .='eng']]">
		<xsl:variable name="dbclass">B</xsl:variable>
        	<xsl:variable name="name">subject</xsl:variable>
    		<xsl:variable name="descriptor">
            	    <xsl:value-of select="marc:subfield[@code='a']/text()" />
        	</xsl:variable>
    			<xsl:variable name="qualifier">
            		    <xsl:value-of select="marc:subfield[@code='a']/text()" />
        		</xsl:variable>
        	        <search_request name="{$name}" dbclass="{$dbclass}">
             		    <xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=21 {', $descriptor, '} @attr 1=12 {', $idB, '}')" />
        		</search_request>
        </xsl:for-each>
        <!-- keywords_id -->
        <xsl:for-each select="b/marc:record/marc:datafield[@tag='606' and marc:subfield[@code='8' and .='eng']]">
		<xsl:variable name="dbclass">B</xsl:variable>
        	<xsl:variable name="name">subject_id</xsl:variable>
        	<xsl:for-each select="marc:subfield[@code='3' and . != '']">
        	    <xsl:variable name="sub_id">
            		<xsl:value-of select="." />
        	    </xsl:variable>
        	    <search_request name="{$name}" dbclass="{$dbclass}">
             		<xsl:value-of select="concat('@not @and  @attr 1=9003 {',$id,'} @attr 1=9004 {', $sub_id, '} @attr 1=12 {', $idB, '}')" />
        	    </search_request>
        	</xsl:for-each>
        </xsl:for-each>

    </xsl:template>
</xsl:stylesheet>

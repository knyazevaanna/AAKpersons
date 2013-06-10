AAK
==========

aak - ������� ��� ������������ ��������� ��� (�������������� ������������ ��������)

aak [--config aak.conf][--pipeline pipeline.xml][--pipeline2 pipeline2.xml]
[--output output.xml][--debug]

��������� ���������������� ����.

 proxy: host:port
 dbclass: A
 dbhost: 127.0.0.1
 dbport: 2100
 dbbases: authors
 dbclass: B 
 dbhost: 127.0.0.1
 dbport: 2100
 dbbases: book
 authorlist: list.txt

pipeline.xml -- ���� ��� ������� XSLT pipeline � ������� XML.

pipeline2.xml -- ���� ��� ������� XSLT pipeline � ������� XML.

output.xml -- �������� ����.


���������� ���� ������� (�� ���������� � � �) ������������ � ���� XML-���������. ���������
XML-�������� ���������� �� ���� pipeline. ������ ������������ pipeline:

 <pipeline>
     <xslt stylesheet='stage1.xsl' />
 </pipeline>

������ ��� ��������� ������ � pipeline:

 <xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    exclude-result-prefixes="marc">
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

    <!-- ������������� �������������� -->

    <xsl:template match="*|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>

    <!-- ��������� ��������� ... -->

 </xsl:stylesheet>

� ���������� ������ pipeline ���������� ����� XML-�������� ����

 <output>
  ...
 </output>

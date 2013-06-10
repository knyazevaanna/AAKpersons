AAK
==========

aak - утилита для тестирование алгоритма ААК (автоматический авторитетный контроль)

aak [--config aak.conf][--pipeline pipeline.xml][--pipeline2 pipeline2.xml]
[--output output.xml][--debug]

Текстовый конфигурационный файл.

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

pipeline.xml -- Файл для задания XSLT pipeline в формате XML.

pipeline2.xml -- Файл для задания XSLT pipeline в формате XML.

output.xml -- Выходной файл.


Полученная пара записей (из источников А и Б) группируются в виде XML-документа. Созданный
XML-документ передается на вход pipeline. Пример конфигурации pipeline:

 <pipeline>
     <xslt stylesheet='stage1.xsl' />
 </pipeline>

Шаблон для обработки записи в pipeline:

 <xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    exclude-result-prefixes="marc">
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" />

    <!-- тоджественное преобразование -->

    <xsl:template match="*|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>

    <!-- обработка документа ... -->

 </xsl:stylesheet>

В результате работы pipeline получается новый XML-документ вида

 <output>
  ...
 </output>

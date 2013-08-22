<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:x="http://www.w3.org/1999/xhtml"
xmlns="http://www.w3.org/1999/xhtml"
exclude-result-prefixes="x">

<xsl:output method="html" omit-xml-declaration="yes" />

<!-- Parts of this stylesheet came from
http://www.w3.org/2004/04/xhlt91/ -->
<!-- By default, copy *everything* -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="comment()">
</xsl:template>

<xsl:template match="x:body">
  \begin{document}
  <xsl:call-template name="frontmatter"/>
  <xsl:apply-templates select="x:frontmatter/*"/>
  \mainmatter
  <xsl:apply-templates select="x:mainmatter/*"/>
  \end{document}
</xsl:template>

<xsl:template match="x:head">
</xsl:template>

<xsl:include href="header.tex" />
<xsl:template match="x:html">
<xsl:call-template name="preamble"/>
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="x:a">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="x:div[@id='header' or @id='TOC' or @class='html']">
</xsl:template>


<xsl:template match="text()">
<xsl:value-of select="."/>
</xsl:template>

<xsl:template name="addcontents">
</xsl:template>

<!-- body sections -->
<xsl:template match="x:frontmatter/x:h1">
  <xsl:text>\chapter*{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
  \addcontentsline{toc}{chapter}{<xsl:apply-templates/>}
  <xsl:call-template name="section-label"/>
</xsl:template>
<xsl:template match="x:h1">
  <xsl:text>\chapter{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
  <xsl:call-template name="section-label"/>
</xsl:template>
<xsl:template match="x:h2">
  <xsl:text>\section*{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
  <xsl:call-template name="section-label"/>
</xsl:template>
<xsl:template match="x:h3">
  <xsl:text>\subsection{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
  <xsl:call-template name="section-label"/>
</xsl:template>
<xsl:template match="x:h4">
  <xsl:text>\subsubsection{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
  <xsl:call-template name="section-label"/>
</xsl:template>
<!-- section labels. -->
<xsl:template name="section-label">
  <xsl:variable name="label" select="../@id"/>
  <!--
      xsl:message> section-label: <xsl:value-of select="$label"/> <xsl:value-of select="position()"/> <xsl:value-of select="."/> </xsl:message
  -->
  <xsl:if test="$label">
    <xsl:text>\label{</xsl:text>
    <xsl:value-of select="$label"/>
    <xsl:text>}</xsl:text>
  </xsl:if>
</xsl:template>
<!-- lists -->
<xsl:template match="x:ul">
  <xsl:text>\begin{itemize}</xsl:text>
  <xsl:for-each select="x:li">
    <xsl:text>\item </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
    </xsl:text>
  </xsl:for-each>
  <xsl:text>\end{itemize}</xsl:text>
</xsl:template>
<xsl:template match="x:ol">
  <xsl:text>\begin{enumerate}</xsl:text>
  <xsl:for-each select="x:li">
    <xsl:text>\item </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
    </xsl:text>
  </xsl:for-each>
  <xsl:text>\end{enumerate}</xsl:text>
</xsl:template>

<!-- misc pre/verbatim -->
<!--
<xsl:template match="x:pre[x:code]">
  <xsl:text>\begin{lstlisting}
</xsl:text>
  <xsl:apply-templates mode="verbatim"/>
  <xsl:text>\end{lstlisting}</xsl:text>
</xsl:template>
-->
<xsl:template match="x:em|x:strong">
  <xsl:text>{\em </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>
<!-- paragraphs -->
<xsl:template match="x:p">
  <xsl:apply-templates/>
  <xsl:text>

</xsl:text>
</xsl:template>
<xsl:template match="x:p[@class='nopar']">
  <xsl:text>\empty</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>\empty</xsl:text>
</xsl:template>
<xsl:template match="x:div[@class='definition' or @class='exercise']">
  <xsl:text>\begin{</xsl:text>
  <xsl:value-of select="@class"/>
  <xsl:text>}</xsl:text>
  <xsl:text></xsl:text>
  <xsl:apply-templates/>
  <xsl:text>\end{</xsl:text>
  <xsl:value-of select="@class"/>
  <xsl:text>}</xsl:text>
  <xsl:text></xsl:text>
</xsl:template>
<xsl:template match="x:q">
  <xsl:text>``</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>''</xsl:text>
</xsl:template>
<xsl:template match="x:div[@class='definition']//x:span[@class='term']">
  <xsl:text>\emph{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="x:a[@href]">
  <xsl:text>\href{</xsl:text><xsl:value-of select="@href"/>}{<xsl:apply-templates/><xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="x:sagecell">
  <xsl:text>\begin{lstlisting}</xsl:text>
  <xsl:apply-templates mode="verbatim"/>
  <xsl:text>\end{lstlisting}</xsl:text>
</xsl:template>

<xsl:template match="x:sagecell/x:pre">
  <xsl:apply-templates select="./x:code/node()"/>
</xsl:template>

<xsl:template match="x:div[@class='asagecell']">
</xsl:template>


<!--       per latex tutorial, the following need escaping: # $ % & ~
     _ ^ \ { } -->

<xsl:template match="text()">
  <xsl:call-template name="esc">
    <xsl:with-param name="c">%</xsl:with-param>
    <xsl:with-param name="s" select="."/>
  </xsl:call-template>
</xsl:template>
<!--
<xsl:template match="text()">
  <xsl:call-template name="esc">
    <xsl:with-param name="c">#</xsl:with-param>
    <xsl:with-param name="s">
      <xsl:call-template name="esc">
        <xsl:with-param name="c">$</xsl:with-param>
        <xsl:with-param name="s">
          <xsl:call-template name="esc">
            <xsl:with-param name="c">%</xsl:with-param>
            <xsl:with-param name="s">
              <xsl:call-template name="esc">
                <xsl:with-param name="c">&amp;</xsl:with-param>
                <xsl:with-param name="s">
                  <xsl:call-template name="esc">
                    <xsl:with-param name="c">~</xsl:with-param>
                    <xsl:with-param name="s">
                      <xsl:call-template name="esc">
                        <xsl:with-param name="c">_</xsl:with-param>
                        <xsl:with-param name="s">
                          <xsl:call-template name="esc">
                            <xsl:with-param name="c">^</xsl:with-param>
                            <xsl:with-param name="s">
                              <xsl:call-template name="esc">
                                <xsl:with-param name="c">{</xsl:with-param>
                                <xsl:with-param name="s">
                                  <xsl:call-template name="esc">
                                    <xsl:with-param name="c">}</xsl:with-param>
                                    <xsl:with-param name="s">
                                      <xsl:call-template name="esc">
                                        <xsl:with-param name="c">\</xsl:with-param>
                                        <xsl:with-param name="s" select="."/>
                                      </xsl:call-template>
                                    </xsl:with-param>
                                  </xsl:call-template>
                                </xsl:with-param>
                              </xsl:call-template>
                            </xsl:with-param>
                          </xsl:call-template>
                        </xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>
-->

<xsl:template name="esc">
  <xsl:param name="s"/>
  <xsl:param name="c"/>
  <xsl:choose>
    <xsl:when test="contains($s, $c)">
      <xsl:value-of select="substring-before($s, $c)"/>
      <xsl:text>\</xsl:text>
      <xsl:choose>
        <xsl:when test="$c = '&quot;'">
          <xsl:text>textbackslash</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$c"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="esc">
        <xsl:with-param name="c" select="$c"/>
        <xsl:with-param name="s" select="substring-after($s, $c)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$s"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



</xsl:stylesheet>

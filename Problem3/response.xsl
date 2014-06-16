<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:exsl="http://exslt.org/common"
                xmlns:regexp="http://exslt.org/regular-expressions"
                extension-element-prefixes="exsl str regexp">
    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="query"/>

    <!-- Suppress default text output -->
    <xsl:template match="text()|@*">
    </xsl:template>

    <xsl:template match="/">
        <xsl:call-template name="parse-query">
            <xsl:with-param name="query" select="$query"/>
        </xsl:call-template>
    </xsl:template>

    <!--
        Parse query string like "tex-box=default&number=3" into node-set:
        <root>
            <param name="text-box" value="default"/>
            <param name="number" value="3"/>
        </root>
    -->
    <xsl:template name="parse-query">
        <xsl:param name="query"/>
        <xsl:variable name="params" select="str:split($query, '&amp;')"/>
        <xsl:variable name="parsed-params">
            <xsl:for-each select="$params">
                <xsl:variable name="pos" select="position()"/>
                <param>
                    <xsl:attribute name="name">
                        <xsl:value-of select="str:split($params[position()=$pos], '=')[position()=1]"/>
                    </xsl:attribute>
                    <xsl:attribute name="value">
                        <xsl:value-of select="str:split($params[position()=$pos], '=')[position()=2]"/>
                    </xsl:attribute>
                </param>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="parsed-query" select="exsl:node-set($parsed-params)"/>
        <xsl:call-template name="validate">
            <xsl:with-param name="parsed-query" select="$parsed-query"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="validate">
        <xsl:param name="parsed-query"/>
        <violations>
            <xsl:apply-templates select="/form/input">
                <xsl:with-param name="parsed-query" select="$parsed-query"/>
            </xsl:apply-templates>
        </violations>
    </xsl:template>

    <!--
        For each "input" of the form checks
        if corresponding param of query string
        is present if it's required.
    -->
    <xsl:template match="input[@required = true()]">
        <xsl:param name="parsed-query"/>
        <xsl:variable name="name" select="./@name"/>
        <xsl:variable name="input" select="$parsed-query/*[@name=$name]"/>

        <!-- Check if required param is present in query string -->
        <xsl:if test="count($input) = 0 and ./@required">
            <violation>
                <xsl:attribute name="field-name">
                    <xsl:value-of select="./@name"/>
                </xsl:attribute>
                <xsl:attribute name="description">
                    <xsl:text>This field is required!</xsl:text>
                </xsl:attribute>
            </violation>
        </xsl:if>
    </xsl:template>

    <!--
    For each "input" of the form checks
    if corresponding param of query string
    is valid according to form.xml definition.
    -->
    <xsl:template match="input[@type = 'text']">
        <xsl:param name="parsed-query"/>

        <xsl:if test="string-length($parsed-query/param/@value) &gt; number(./@max-length)">
            <violation>
                <xsl:attribute name="field-name">
                    <xsl:value-of select="./@name"/>
                </xsl:attribute>
            </violation>
        </xsl:if>
        <xsl:if test="not(regexp:test($parsed-query/param/@value, /@regexp))">
            <violation>
                <xsl:attribute name="field-name">
                    <xsl:value-of select="./@name"/>
                </xsl:attribute>
            </violation>
        </xsl:if>

    </xsl:template>

    <!--
    For each "input" of the form checks
    if corresponding param of query string
    is valid according to form.xml definition.
    -->
    <xsl:template match="input[@type = 'number']">
        <xsl:param name="parsed-query"/>

        <xsl:if test="$parsed-query/param/@value &lt; ./@min or $parsed-query/param/@value &gt; ./@max">
            <violation>
                <xsl:attribute name="field-name">
                    <xsl:value-of select="./@name"/>
                </xsl:attribute>
            </violation>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
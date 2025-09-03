<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
>
	<xsl:template match="@*|node()">
		<xsl:choose>
			<xsl:when test="@xlink:href and not(starts-with(@xlink:href, '#'))">
				<xsl:variable name="external-filename" select="substring-before(@xlink:href, '#')"/>
				<xsl:variable name="referenced-id" select="substring-after(@xlink:href, '#')"/>
				<xsl:variable name="external-doc" select="document($external-filename)"/>
				<xsl:apply-templates select="$external-doc//*[@id = $referenced-id]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

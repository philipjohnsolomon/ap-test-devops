<xsl:stylesheet version="2.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- identity transform -->
	<!-- illustrates framework's ability to resolve imported XSLTs -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
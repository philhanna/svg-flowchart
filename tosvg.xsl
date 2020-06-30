<?xml version="1.0"?>

<xsl:stylesheet
      xmlns="http://www.w3.org/2000/svg"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xalan="http://xml.apache.org/xslt"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      exclude-result-prefixes="xalan"
      version="1.0" >

   <xsl:output method="xml"
               cdata-section-elements="style"
               doctype-public="-//W3C//DTD SVG 1.1//EN"
               doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
               encoding="UTF-8"
               indent="yes"
               xalan:indent-amount="3"
               />

   <xsl:template match="/">
      <xsl:apply-templates select="flowchart"/>
   </xsl:template>

   <xsl:template match="flowchart">
      <svg version="1.1">
         <xsl:attribute name="viewBox">
            <xsl:text>0 0 620 950</xsl:text>
         </xsl:attribute>
         <rect width="100%" height="100%" fill="white"/>
         <defs>
            <xsl:call-template name="style"/>
            <xsl:call-template name="block-definitions"/>
         </defs>
         <xsl:apply-templates select="row"/>
      </svg>
   </xsl:template>

   <xsl:template match="row">
      <xsl:param name="ROW" select="position()"/>
      <xsl:param name="X" select="10"/>
      <xsl:param name="Y" select="100*($ROW - 1)"/>
      <xsl:comment>
         <xsl:value-of select="concat('Row ', $ROW)"/>
      </xsl:comment>
      <g>
         <xsl:attribute name="id">
            <xsl:value-of select="concat('row', $ROW)"/>
         </xsl:attribute>
         <xsl:attribute name="transform">
            <xsl:value-of select="concat('transform(', $X, ',', $Y, ')')"/>
         </xsl:attribute>
         <xsl:apply-templates select="block"/>
      </g>
      <xsl:comment>
         <xsl:value-of select="concat('End of row ', $ROW)"/>
      </xsl:comment>
   </xsl:template>

   <xsl:template match="block[@type='decision']">
      <g>
         <use xlink:href="#decision"/>
      </g>
   </xsl:template>

   <xsl:template match="block">
      <g>
         <xsl:comment><xsl:value-of select="concat('type=', @type)"/></xsl:comment>
      </g>
   </xsl:template>

   <xsl:template name="style">
            <style><![CDATA[
.line {
   stroke: #4677bf;
   fill: none;
   marker-end: url(#arrow);
}
.label {
   font-family: sans-serif;
   font-size: 8pt;
}
#arrow {
   stroke: #4677bf;
   fill: #4677bf;
}
#process, #offlineprocess, #terminal, #connector, #decision {
   fill: #e8eef7;
   stroke: #000000;
}
]]></style>
   </xsl:template>

   <xsl:template name="block-definitions">
      <xsl:comment>Flowcharting block definitions</xsl:comment>
      <g>
         <xsl:attribute name="id">
            <xsl:text>process</xsl:text>
         </xsl:attribute>
         <rect width="100" height="60" stroke-width="1"/>
      </g>

      <g>
         <xsl:attribute name="id">
            <xsl:text>offlineprocess</xsl:text>
         </xsl:attribute>
         <rect width="100" height="60" stroke-width="1"/>
         <path d="M 12 0 V 60 M 88 0 V 60"/>
      </g>

      <g>
         <xsl:attribute name="id">
            <xsl:text>terminal</xsl:text>
         </xsl:attribute>
         <rect id="terminal" x="0" y="10" width="100" height="40" rx="20" ry="20"/>
      </g>

      <g>
         <xsl:attribute name="id">
            <xsl:text>decision</xsl:text>
         </xsl:attribute>
         <path d="M 50 0 L 100 30 L 50 60 L 0 30 z"/>
      </g>

      <g>
         <xsl:attribute name="id">
            <xsl:text>connector</xsl:text>
         </xsl:attribute>
         <circle cx="50" cy="30" r="20"/>
      </g>

      <marker markerWidth="16" markerHeight="8" refX="0" refY="4" orient="auto" markerUnits="stroke-width">
         <xsl:attribute name="id">
            <xsl:text>arrow</xsl:text>
         </xsl:attribute>
         <path d="M 0 0 8 4 0 8z"/>
      </marker>

      <xsl:comment>End of flowcharting block definitions</xsl:comment>
   </xsl:template>

</xsl:stylesheet>

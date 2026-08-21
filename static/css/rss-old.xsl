<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title><xsl:value-of select="/rss/channel/title"/> RSS Feed</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
        <meta charset="UTF-8"/>
        <style>
          body {
            margin: auto;
            max-width: 40em;
            font-family: monospace;
            }

          article {
            padding-bottom: 1em;
            border-bottom: 1px dotted #111;
            }

          img{
            width: 100%
            }

          @media (prefers-color-scheme: dark) {
            body {
                background-color: #111;
                color: gainsboro;
                }

            h1, h2, h3, h4, h5, h6 {
                color: silver;
                }

            a, a:hover, a:visited {
                color: gainsboro;
                }

            article {
                border-bottom: 1px dotted silver;
            }
          }

        </style>
      </head>
      <body>
        <header>
          <h1><xsl:value-of select="/rss/channel/title"/></h1>
            <p>This is a web feed, also known as an RSS feed. <strong>Subscribe</strong> by copying the URL into your RSS reader. To know more read <a href="https://aboutfeeds.com/" target="_blank"><strong>About Feeds</strong></a> by Matt Webb.</p>
            <p><xsl:value-of select="/rss/channel/description"/></p>
            <p><a hreflang="en"><xsl:attribute name="href"><xsl:value-of select="/rss/channel/link"/></xsl:attribute>Visit Website →</a></p>
        </header>
        <main>
          <h2>Recent Posts</h2>
          <xsl:for-each select="/rss/channel/item">
            <article>
              <p><a hreflang="en" target="_blank"><xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
              <xsl:choose>
                <xsl:when test="string-length(normalize-space(title)) > 0">
                  <xsl:value-of select="title"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="SanitizedDescription" select="normalize-space(substring-after(description,'&lt;p&gt;'))"/>
              <xsl:call-template name="remove-html">
  <xsl:with-param name="text" select="concat(substring($SanitizedDescription, 1, 30), substring-before(substring($SanitizedDescription, 31), ' '), '...')" />
</xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>

              </a></p>
                           <footer>Published: <time><xsl:value-of select="pubDate" /></time></footer>
            </article>
          </xsl:for-each>
        </main>
      </body>
    </html>
  </xsl:template>


<!-- Source of the below template: https://maulikdhorajia.blogspot.com/2011/06/removing-html-tags-using-xslt.html -->
<xsl:template name="remove-html">
    <xsl:param name="text"/>
    <xsl:choose>
        <xsl:when test="contains($text, '&lt;')">
            <xsl:value-of select="substring-before($text, '&lt;')"/>
            <xsl:call-template name="remove-html">
                    <xsl:with-param name="text" select="substring-after($text, '&gt;')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
</xsl:stylesheet>

# Replace any ./*.org links with ./*.html links
html_sed = sed -E 's/(\.\/\S*\.)org/\1html/'
html_out_css_template = -t html -c css/retro.css --template=template.html
html :
	pandoc index.org $(html_out_css_template) --metadata title="Welcome!" | $(html_sed) > index.html
	pandoc about.org $(html_out_css_template) --metadata title="About Me" | $(html_sed) > about.html
	pandoc tao.org $(html_out_css_template) --metadata title="The Tao of Programming" | $(html_sed) > tao.html

# Pandoc escapes single and double quotes and asterisks when converting to
# Markdown... which translates to literal backslashes in gemtext, but doesn't
# with the older GitHub-flavored Markdown output mode (markdown_github rather
# than gfm). However, it does escape angled brackets, so we need to replace
# those with their literal counterparts.
md_sed = sed 's/\\</</' | sed 's/\\>/>/' | sed 's/\\\*/\*/'
md :
	pandoc index.org -t markdown_github | $(md_sed) > index.md
	pandoc about.org -t markdown_github | $(md_sed) > about.md
	pandoc tao.org -t markdown_github | $(md_sed) > tao.md

gemtext :
	gemgen index.md
	gemgen about.md
	gemgen tao.md


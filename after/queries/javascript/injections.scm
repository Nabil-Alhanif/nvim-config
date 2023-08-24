; extends
(
	(comment) @_comment-text
	(#match? @_comment-text "html")
	((template_string) @injection.content
		(#set! injection.language "html"))
)

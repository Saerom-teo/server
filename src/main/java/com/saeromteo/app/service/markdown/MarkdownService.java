package com.saeromteo.app.service.markdown;

import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.util.data.MutableDataSet;
import org.springframework.stereotype.Service;

@Service
public class MarkdownService {
	private final Parser parser;
	private final HtmlRenderer renderer;

	public MarkdownService() {
		MutableDataSet options = new MutableDataSet();
		parser = Parser.builder(options).build();
		renderer = HtmlRenderer.builder(options).build();
	}

	public String convertToHtml(String markdown) {
		return renderer.render(parser.parse(markdown));
	}
}

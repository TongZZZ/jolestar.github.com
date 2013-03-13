---
title: 使用jeklly搭建自己的blog
author: jolestar
layout: post
permalink: /use-jekyll-as-blog
tags:
  - blog
  - 爬行在网上
---

博客荒废好久了，杂草丛生，都不好意思打开了。那天看到一个用git作为博客存储的博客搭建工具: jekyll，github的page服务就使用的是它。和我去年用git后产生的用git做wiki以及博客服务的思路类似，于是又激起了我捣鼓博客的兴趣。

<!--more-->

## 首页解决方案

### 博客摘要

博客摘要的功能当前有几种方式

1. 插件方式
	
	_plugins/more.rb:

		module More
		    def more(input, type)
		        if input.include? "<!--more-->"
		            if type == "excerpt"
		                input.split("<!--more-->").first
		            elsif type == "remaining"
		                input.split("<!--more-->").last
		            else
		                input
		            end
		        else
		            input
		        end
		    end
		end

		Liquid::Template.register_filter(More)
	
	博客中增加标记
	
		---
		layout: post
		title: "Your post title"
		published: true
		---
		<p>This is the excerpt.</p>
		<!--more-->
		<p>This is the remainder of the post.</p>

	获取摘要方法
	
		<summary>{{ post.content | more: "excerpt" }}</summary>
	获取全文
	
		<article>{{ post.content | more: "remaining" }}</article>		

2. liquid 过滤器方式

	strip_html | truncatewords
	http://kaspa.rs/2011/04/jekyll-hacks-html-excerpts/

3. js操作模式
	
	http://blog.evercoding.net/2013/03/09/traversing-dom-tree-with-javascript/
	
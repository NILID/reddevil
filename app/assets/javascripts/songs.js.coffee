$ ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Load items...")
        $.getScript(url)
    $(window).scroll()

  if $('.paginator').length
    $(window).scroll ->
      url = $('.paginator .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.paginator').text("Load items...")
        $.getScript(url)
    $(window).scroll()
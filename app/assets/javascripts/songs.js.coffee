$ ->
  if $('.div-pagy .pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Load items...")
        $.getScript(url)
    $(window).scroll()
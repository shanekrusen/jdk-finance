$(document).ready(function() {
    $('.month-box').hide();
    $('.month-box').first().show();

    $('.month-button').first().toggleClass('active')

    $('.month-button').click(function() {
        $('.month-box').hide();
        var month_text = $(this).text() + ' ' + $(this).parent().find('h1').text();
        console.log(month_text);
        $('.month-box').find("h1:contains(" + month_text + ")").parent().show();
        $('.active').toggleClass('active');
        $(this).toggleClass('active');
    });

    $('.day-box').each(function() {
        var sum = 0.0;
        $(this).find(".income-price").each(function() {
            sum += parseFloat($(this).text());
        });
        $(this).find('.income-total').text("$" + sum.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
    });

    $('.income-price').each(function() {
        var text = parseFloat($(this).text());
        $(this).text("$" + text.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
    });

    $('.close').click(function() {
        $(this).slideToggle();
    });
});

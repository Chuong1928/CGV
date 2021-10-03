console.log("loaded")
var time = $('.choosen-time');
$('input[name=day_show_film]').on('change',function(){

    let film_id = $(".movie").attr("data-phim")
        $.ajax({
                url: `/films/${film_id}`,
                data: {
                    search: {
                        date: $(this).val()
                    },
                    authenticity_token: AUTH_TOKEN
                },
                type: 'GET',
                dataType: 'script',
            }).done(function (data) {
                console.log(data)
            }).fail(function () {
                console.log(data)
            })
});

$(document).on('click',"a.date",function(){
    // code
    if($(".this_film").length != 0){
        $(".this_film").addClass("d-none");
    }

    let date = $(this).attr("data-date")
    // xoa class active truoc do
    $(".active").removeClass("active")
    //addclass active cho ngay duoc chon
    $(this).addClass("active")
    console.log(date);
    $.ajax({
        url: `/screen`,
        data: {
            filter: {
                date:date
            },
            authenticity_token: AUTH_TOKEN
        },
        type: 'GET',
        dataType: 'script',
        }).done(function (data) {
            console.log(data)
        }).fail(function () {
            console.log(data)
        })
       
    });

$('a.day_show_film').on('click',function(){
    // code
    let date = $(this).attr("data-date")
    let film_id = $(".movie").attr("data-phim")
    // xoa class active truoc do
    $(".active").removeClass("active")
    //addclass active cho ngay duoc chon
    $(this).addClass("active")
    console.log(date);
    $.ajax({
        url: `/films/${film_id}/ticket_order`,
        data: {
            search: {
                date: date
            },
            authenticity_token: AUTH_TOKEN
        },
        type: 'GET',
        dataType: 'script',
        }).done(function (data) {
            console.log(data)
        }).fail(function () {
            console.log(data)
        })
        
    });

    
    $(document).on('click', '.time-select__item',function(){
        //visual iteractive for choose
        $('.time-select__item').removeClass('active');
        $(this).addClass('active');

        //data element init
        var chooseTime = $(this).attr('data-screen');
        let url= $(this).attr("data-url");

        $("a#next_step_pick_seat").attr("href", url+"/"+chooseTime)
        //data element init
       // var chooseCinema = $(this).parent().parent().find('.time-select__place').text(); 

        //data element set
         time.val(chooseTime);
         console.log(time.val())
        // cinema.val(chooseCinema);
    });  
   
    $(document).on("click", ".time-select__item",function(){
      
        if($(this).hasClass("active")){
            console.log($(this).attr("data-url"));
            $(".this_film").removeClass("d-none");
            var chooseTime = $(this).attr('data-screen');
            let url= $(this).attr("data-url");
            $("a.book_now").attr("href", url+"/"+chooseTime)
            $(".ticked_film_name").text("Tên phim  : "+ $(this).find(".this-film_name").text())
            $(".ticked_film_time").text("Thời gian : "+ $(this).find(".this-film_time").text())
        }
      
    })
    //3. Choose sits (and count price for them)
    //users choose sits

    //data elements init
    var sum = 0;
    var cheap = 0;
    var middle = 0;
    var expansive = 0;
    

    $('.sits__place').on("click",function (e) {
        e.preventDefault();
        var place = $(this).attr('data-place');
        var ticketPrice = $(this).attr('data-price');

        if(! $(e.target).hasClass('sits-state--your')){

            if (! $(this).hasClass('sits-state--not') ) {
                $(this).addClass('sits-state--your');

                $('.checked-place').prepend('<span class="choosen-place '+place+' px-2 display-5">'+ place +'</span>');

                switch(ticketPrice)
                    {
                    case '50000':
                        sum += 50000;
                        cheap += 1;
                        break;
                    case '100000':
                        sum += 100000;
                        middle += 1;
                        break;
                }

                $('.checked-result').text(sum+' (VND)');
            }
        }

        else{
            $(this).removeClass('sits-state--your');
            
            $('.'+place+'').remove();

            switch(ticketPrice)
                    {
                    case '50000':
                        sum -= 50000;
                        cheap -= 1;
                        break;
                    case '100000':
                        sum -= 100000;
                        middle -= 1;
                        break;
                
                }

            $('.checked-result').text(sum+' (VND)')
        }
    })
$(".booking-pagination__next").on("click",function(e){
    if(time.val() ==  ""){
        e.preventDefault()
        alert("Bạn chưa chọn suất chiếu nào! Hãy chọn 1 suất chiếu")
    }
})
var list_seat_id = [];
var list_seat_name = [];
$("a.next_step_payment").on('click',function(e){
    if($('.web.checked-result').text().trim() == "0(VND)" || $('.web.checked-result').text() == "0 (VND)"){
        e.preventDefault()
        alert("Bạn chưa chọn ghế ngồi! Hãy chọn 1 vị trí muốn đặt")
    }
    $("span.sits-state--your").each(function(){
        list_seat_id.push($(this).attr("data-seat-id"))
        list_seat_name.push($(this).attr("data-place"))
     })
   sessionStorage.setItem('list_seat_id', list_seat_id);
   sessionStorage.setItem('total_payment',$('.web.checked-result').text())
   sessionStorage.setItem('list_seat_name', list_seat_name);
})
let tick_ket_count = 0;
if(sessionStorage.getItem('list_seat_name')!= null ){
    tick_ket_count = sessionStorage.getItem('list_seat_name').split(",").length
}
$(".book-result__count.booking-ticket").text(sessionStorage.getItem('list_seat_name')+" ("+(tick_ket_count)+" Vé"+")")
$(".book-result__count.booking-cost").text((sessionStorage.total_payment))


$(".add-food_to_order").on('click',function(e){
    e.preventDefault()
    let food_id = $(this).prev().attr("data-food-id")
    let price   = $(this).prev().attr("data-food-price")
    $('.food-detail').append('<span class="text-muted d-block your-food" data-food-price-pick = "'+price+'" data-food-pick = "'+food_id+'">'+$(this).prev().text()+' x<span class="food-quantity">1</span></span>');
    $(".food-order").removeClass("d-none").addClass("d-flex")
    $(this).closest(".hahaha").find("input.form-control").val(1)
    let current_food_payment = parseInt($(".food-order").find(".pay-food").text())
    let ticket_payment = $(".book-result__item .booking-cost").text().split(" ")[0];
    
    if(current_food_payment){
        let total = current_food_payment+parseInt(price)
        $(".food-order").find(".pay-food").text(total+" (VND)")
        $(".total-payment .total-payment-cost").text(total+parseInt(ticket_payment)+" (VND)")
        
    }else{
        $(".food-order").find(".pay-food").text(price+" (VND)")
        $(".total-payment .total-payment-cost").text(parseInt(price)+parseInt(ticket_payment)+" (VND)")
    }
    
    $(this).addClass("d-none")
    $(this).next().removeClass("d-none")
    

})

$(document).on('click', '.bootstrap-touchspin-down',function(){
   
    let food_picked_id = $(this).closest(".hahaha").find("p.card-title").attr("data-food-id")
    let quantity = $(this).closest(".input-group-prepend").next().val();
    let current_food = ($("[data-food-pick="+food_picked_id+"]").find(".food-quantity"))
    let current_food_payment = parseInt($(".food-order").find(".pay-food").text())
    current_food.text(quantity)
    if(quantity == 0){
        $(this).closest(".set_quantity_food").prev().removeClass("d-none")
        $(this).closest(".set_quantity_food").addClass("d-none")
        //current_food.closest(".text-muted").remove()
        //current_food_payment = 0
    }

    //
    let price_of_food = ($("[data-food-pick="+food_picked_id+"]").attr("data-food-price-pick"))
    let total = 0
    if(current_food_payment){
        
         total = current_food_payment-parseInt(price_of_food)
        $(".food-order").find(".pay-food").text(total+" (VND)")
        
        if(total == 0 || quantity == 0){
            current_food.closest(".text-muted").remove()
        }
        
    }
    let ticket_payment = $(".book-result__item .booking-cost").text().split(" ")[0];
    
    $(".total-payment .total-payment-cost").text(total+parseInt(ticket_payment)+ " (VND)")

})

let curent_total_price = 0;
$(document).on('click', '.bootstrap-touchspin-up',function(){
    let food_quantity_pick = $(this).closest(".input-group-append").prev().val()
    curent_total_price = parseInt($(".food-order").find(".pay-food").text())
    // console.log($(this).closest(".hahaha").find("p.card-title").attr("data-food-id"))
    let food_picked_id = $(this).closest(".hahaha").find("p.card-title").attr("data-food-id")
    //console.log(food_picked_id)
    let current_food = ($("[data-food-pick="+food_picked_id+"]").find(".food-quantity"))
  
    current_food.text(food_quantity_pick)

    let price_of_food = ($("[data-food-pick="+food_picked_id+"]").attr("data-food-price-pick"))
    
    let total = 0;
    let current_food_payment = parseInt($(".food-order").find(".pay-food").text())
    if(current_food_payment){
         total = current_food_payment+parseInt(price_of_food)
        $(".food-order").find(".pay-food").text(total+" (VND)")
    }
    let ticket_payment = $(".book-result__item .booking-cost").text().split(" ")[0];
    
    $(".total-payment .total-payment-cost").text(total+parseInt(ticket_payment)+" (VND)")
   
})

$(".btn-payment").on("click", function(e){
    let  current_user = $(".back_to_home_page").attr("data-user")
    //console.log(current_user);
    $(this).attr("disabled", true);
    e.preventDefault()
    console.log("thanh toán");
    let seat_id = sessionStorage.getItem('list_seat_id')
    let seat_name = sessionStorage.getItem('list_seat_name')
    let total_payment = $(".total-payment").find(".total-payment-cost").text().split(" ")[0];
    let screening_id = $(".screening-info").attr("data-screening-id")
    let list_food_id = []
    if($("span.your-food").length != 0){
        $("span.your-food").each(function(){
            list_food_id.push({
                id: $(this).attr("data-food-pick"),
                quantity: $(this).find(".food-quantity").text().trim()
            })
         })
    }
    
    console.log(list_food_id);
   
    $.ajax({
        url: `/order`,
        data: {
            order: {
                seat_id: seat_id,
                list_food_id: list_food_id,
                seat_name: seat_name,
                total_payment: total_payment,
                screening_id : screening_id
            },
            authenticity_token: AUTH_TOKEN
        },
        type: 'POST',
        dataType: 'json',
        }).done(function (data) {
            console.log(data)
            $(".open-modal").trigger( "click" );
            $(".modal-message").html(data.message)
            if(data.success){
                $(".book_fail").addClass("d-none")
            }else{
                $(".book_success").addClass("d-none")
            }
            
            $(function(){
                let spanCount = $("span.back_home_page");
                console.log(spanCount);
                let count = 5;
                    countable= setInterval(function (){

                        spanCount.text(count)

                        if(count > 0){
                            count -= 1;
                        }else if(count <= 0){
                                clearInterval(countable);
                                window.location=`/account/${current_user}`
                        }

                }, 1000);
            })
        }).fail(function () {
            console.log("Lỗi")
        })

})
$(function(){
    $(".sent_ticket_to_mail").on("click",function(e){
        e.preventDefault()
        let ticket_id = $(".ticket__item").attr("data-order-id")
    
        console.log(ticket_id);
        $.ajax({
            url: `/order/sent_you_ticket`,
            data: {
                mail: {
                    ticket_id: ticket_id
                },
                authenticity_token: AUTH_TOKEN
            },
            type: 'POST',
            dataType: 'json',
            }).done(function (data) {
                console.log(data)
                $(function(){
                    toastr.success(data.message)
                })
            }).fail(function () {
                console.log(data)
            })
    
    })
})

$(".cancel-order").on("click", function(e){
    e.preventDefault()
    console.log("Hủy đặt vé");
    let self = $(this)
    let order_id = $(this).attr("data-order-id-del")
    console.log(order_id);
    $.ajax({
        url: `/order/cancel_order`,
        data: {
            order: {
                order_id: order_id
            },
            authenticity_token: AUTH_TOKEN
        },
        type: 'POST',
        dataType: 'json',
        }).done(function (data) {
            console.log(data)
            
            self.closest(".order-detail").find("td").css("text-decoration", "line-through")
            self.text("Bạn đã hủy đơn hàng này").removeClass("cancel-order btn-warning").attr("disabled", true).addClass("disabled btn-secondary");
            self.closest(".action-order").find(".ticket_detail_view").remove()
            $(function(){
                toastr.success(data.message)
            })
        }).fail(function () {
            console.log(data)
        })
    //console.log(film_cancel.text());
})
// display animate load 
function displayAnimateLoad(action){
    
    if(action == 'hide'){
     return   $(".wraper-animate").addClass("d-none")
    }
    $(".wraper-animate").removeClass("d-none")
}
// before ajax send
$( document ).ajaxSend(function() {
    displayAnimateLoad()
});
//  ajax send Complete
$( document ).ajaxComplete(function() {
    displayAnimateLoad('hide')
  });


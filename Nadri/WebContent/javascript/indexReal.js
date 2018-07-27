/**
 * 
 */


$(function(){
	
/*	$.get('/nadri/nadriIndex',function(data,status){
		console.log(data.boardList.length);
		for(i = 0; i < data.boardList.length; i++){
			console.log(data.boardList[i]);
		}
	})*/

	$('.spots').on('mouseenter',function(){
		var name = $(this).attr('id');
		$('.'+name).closest('label').css('color','#00000099');
		$('.'+name).closest('label').css('-webkit-background-clip','unset');
		$('.'+name).closest('label').css('background-color','transparent');
		$('img[name='+name+']').css('opacity','0.8');
		$('img[name='+name+']').attr('src','/images/common/'+name+'_color.png');		
	});
	
	$('.spots').on('mouseleave',function(){
		var name = $(this).attr('id');
		$('.'+name).closest('label').css('color','transparent');
		$('.'+name).closest('label').css('-webkit-background-clip','text');
		$('.'+name).closest('label').css('background-color','#56565694');
		$('img[name='+name+']').css('opacity','0.15');
		$('img[name='+name+']').attr('src','/images/common/'+name+'.png');
	})
	
	
	var t_chk = true;
	$('.title-section').on('click',function(){
		$('#jolly-icon').attr('class','glyphicon glyphicon-ice-lolly');
		$('#jolly-icon').css('animation','unset');
		if(t_chk){	
			$('.head-section').css('height','70px');
			$(this).css('top','70px');
			t_chk = false;
		}else{
			$('.head-section').css('height','10px');
			$(this).css('top','10px');
			$(this).css('cursor','pointer');
			t_chk = true;
		}
		
	});
	
	$('.title-section').on('mouseenter',function(){
		$('.title-section > span').css('opacity','0');
		$('.title-section > div').css('opacity','1');
	})
	
	$('.title-section').on('mouseleave',function(){
		$('.title-section > span').css('opacity','1');
		$('.title-section > div').css('opacity','0');
	})
	
	$('.more-than-three').slick({
		prevArrow:"<span class='glyphicon glyphicon-triangle-left slide-button'></span>",
		nextArrow:"<span class='glyphicon glyphicon-triangle-right slide-button'></span>",
		centerMode: true,
		centerPadding: '60px',
		slidesToShow: 3,
		autoplay: true,
		autoplaySpeed: 2000,
		responsive: [
		    {
		      breakpoint: 768,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 3,
		        autoplay: true,
		        autoplaySpeed: 2000
		      }
		    },
		    {
		      breakpoint: 480,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1,
		        autoplay: true,
		        autoplaySpeed: 2000
		      }
		    }
		  ]
	});
	
	$('.list-element').on('mouseover',function(){
		var id = $(this).attr('id');
		var cls = $(this).attr('class');
		var clsp = cls.split(' ');
		var clsp1 = clsp[1]
		var count = clsp1.charAt(clsp1.length-1);
		$('.info'+count).css('visibility','visible');
	})
	
	$('.list-element').on('mouseleave',function(){
		var id = $(this).attr('id');
		var cls = $(this).attr('class');
		var clsp = cls.split(' ');
		var clsp1 = clsp[1]
		var count = clsp1.charAt(clsp1.length-1);
		$('.info'+count).css('visibility','hidden');
	})
	
	$(window).on('scroll',function(){
		if ($(document).scrollTop() < 70) {
			$('.head-section').css('height','70px');
			$('.head-section').css('border-bottom','0px solid #404548');
			$('.title-section').css('opacity','0');
			$('.title-section').css('pointer-events','none');
			$('.title-section').css('top','70px');
		} else {
			$('.head-section').css('height','10');
			$('.head-section').css('border-bottom','10px solid #404548');
			$('.title-section').css('opacity','1');
			$('.title-section').css('pointer-events','all');
			$('.title-section').css('top','10px');
		}
	})

	
})

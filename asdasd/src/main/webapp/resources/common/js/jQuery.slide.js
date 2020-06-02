; (function ($) {

	// �����̵� �� �÷�����
	// currentPosition: 0,		������ġ, ������ġ
	// slideWidth: 260,		�����̵� ���� ������
	// slideHeight: 160,		�����̵� ���� ������
	// slideId: 'slide',			���� ������ ���̵�
	// leftBtnId: 'left',			���� ��ư ���̵�
	// rigthBtnId: 'right',		������ ��ư ���̵�
	// slideLoop: true			�ݺ� ����
	// ��� ��
	// $('#slidesContainer').slideShow({currentPosition:0, slideWidth: 260});
	//				==> {currentPosition:0, slideWidth: 260} ���� ���� ��� �⺻ ��

	$.fn.slideShow = function(options) {
	  
	  var opts = jQuery.extend({}, jQuery.fn.slideShow.defaults, options);
		 
	  return this.each(function() {
	
		//�����̵� �ڽĵ� ��������
		var $slides = $('.'+opts.slideId);
		//�����̵� �ڽĵ� ����
		var numberOfSlides = $slides.length;
		//�����̵� ���� ��ư
		var $leftBtn = $('#'+opts.leftBtnId);
		//�����̵� ���� ��ư
		var $rigthBtn = $('#'+opts.rigthBtnId);
		
		//�ݺ����� �ʰ� �������� 0 �� ��� ���� ��ư �����
		if( !opts.slideLoop && opts.currentPosition == 0 ) $leftBtn.hide();
		if( !opts.slideLoop && opts.currentPosition == (numberOfSlides - 1) ) $rigthBtn.hide();
		
		//����, ���� ��ư�� �׼� �߰�
		$leftBtn.click(function(){
			Slide('pre');
		});
		$rigthBtn.click(function(){
			Slide('next');
		});

		//�ڽĳ�带 ���ο� div �� ���
		$slides.wrapAll('<div id="'+opts.slideShowId+'"></div>').css({'width' : opts.slideWidth, 'height': opts.slideHeight});
		
		//�� ��ü ���
		var $sliderInner = $('#'+opts.slideShowId);
		$sliderInner.css('width', opts.slideWidth * numberOfSlides);
		
		//�¿� �����̵� �� ���
		if( opts.slideWay == 'left' )
		{
			$slides.css({'float':'left'});
			$sliderInner.animate({
				'marginLeft' : opts.slideWidth * (-opts.currentPosition)	
			});
		}
		else	//���� �����̵��� ���
		{
			$sliderInner.animate({
				'marginTop' : opts.slideHeight * (-opts.currentPosition)
			});
		}
		
		//��ư Ŭ���� ���� �Լ�
		function Slide(preNext) 
		{
			if( preNext == 'pre' )
			{
				opts.currentPosition = opts.currentPosition - 1;

				//�����̸鼭 ���� ��ġ�� 0���� ���� ���
				if( opts.slideLoop )
				{
					if( opts.currentPosition < 0 )
					{
						opts.currentPosition = 1;
						
						if( opts.slideWay == 'left' ) $sliderInner.css( 'marginLeft', opts.slideWidth * (-opts.currentPosition) );
						else $sliderInner.css( 'marginTop', opts.slideHeight * (-opts.currentPosition) );

						$('#'+opts.slideShowId +' div:last-child').insertBefore($('#'+opts.slideShowId +' div:first-child'));
						opts.currentPosition = 0;
					}
				}
				else if( opts.currentPosition <= 0 )
				{
					opts.currentPosition = 0;
					$rigthBtn.show();
					$leftBtn.hide();
				}
			}
			else
			{
				opts.currentPosition = opts.currentPosition + 1;
				
				//�����̸鼭 ������ġ�� ��ü���� Ŭ ���
				if( opts.slideLoop )
				{
					if( opts.currentPosition > numberOfSlides - 1 )
					{
						opts.currentPosition = numberOfSlides - 2;

						if( opts.slideWay == 'left' ) $sliderInner.css( 'marginLeft', opts.slideWidth * (-opts.currentPosition) );
						else $sliderInner.css( 'marginTop', opts.slideHeight * (-opts.currentPosition) );

						$('#'+opts.slideShowId +' div:first-child').insertAfter($('#'+opts.slideShowId +' div:last-child'));
						opts.currentPosition = opts.currentPosition + 1;
					}
				}
				else if( opts.currentPosition >= numberOfSlides - 1 )
				{
					opts.currentPosition = numberOfSlides - 1;
					$leftBtn.show();
					$rigthBtn.hide();
				}
			}

			//����, �¿콽���̵� �׼� ����
			if( opts.slideWay == 'left' )
			{
				$sliderInner.animate({
					'marginLeft' : opts.slideWidth * (-opts.currentPosition)
				});
			}
			else
			{
				$sliderInner.animate({
					'marginTop' : opts.slideHeight * (-opts.currentPosition)
				});
			}
		}
	  });
	};

	//slideShow �÷������� �⺻ �ɼǵ��̴�.
	jQuery.fn.slideShow.defaults = {
		currentPosition: 0,			//������
		slideWidth: 260,				//���λ�����
		slideHeight: 160,			//���λ�����
		slideId: 'slide',				//�ڽĳ�� ���̵�
		leftBtnId: 'left',				//������ư ���̵�
		rigthBtnId: 'right',			//������ư ���̵�
		slideShowId: 'slideInner',		//�����̵� �θ� ������ ���̵�
		slideWay: 'left',				//�����̵� ����	���� ��� ����
		slideLoop: true				//�ݺ� ����  false �� ��� ����
	}; 
}) (jQuery);

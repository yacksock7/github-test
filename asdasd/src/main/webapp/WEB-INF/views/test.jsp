<html>
<head>
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<meta charset="UTF-8">

<style>
@import 'https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300';

html,
body {
  width: 100%;
  height: 100%;
  overflow: hidden;
  margin: 0;
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  font-family: 'Open Sans Condensed', sans-serif;
}

div[class*=box] {
    height: 33.33%;
    width: 100%; 
  display: flex;
  justify-content: center;
  align-items: center;
}

.box-1 { background-color: #FF6766; }

.btn-modal {
    line-height: 50px;
    height: 50px;
    text-align: center;
    width: 250px;
    cursor: pointer;
}

/* 
========================
      BUTTON ONE
========================
*/
.btn-one {
    color: #FFF;
    transition: all 0.3s;
    position: relative;
}
.btn-one span {
    transition: all 0.3s;
}
.btn-one::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
    opacity: 0;
    transition: all 0.3s;
    border-top-width: 1px;
    border-bottom-width: 1px;
    border-top-style: solid;
    border-bottom-style: solid;
    border-top-color: rgba(255,255,255,0.5);
    border-bottom-color: rgba(255,255,255,0.5);
    transform: scale(0.1, 1);
}
.btn-one:hover span {
    letter-spacing: 2px;
}
.btn-one:hover::before {
    opacity: 1; 
    transform: scale(1, 1); 
}
.btn-one::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
    transition: all 0.3s;
    background-color: rgba(255,255,255,0.1);
}
.btn-one:hover::after {
    opacity: 0; 
    transform: scale(0.1, 1);
}
</style>


</head>

<body>
<!-- Hover #1 -->
<div class="box-1">
  <div class="btn btn-one">
    <span>HOVER ME</span>
  </div>
</div>
	<script>
	$(document).ready(function() {
		
	});

	 function dialog() {
		  // Declare variables
		  var dialogBox = $('.dialog'),
		      dialogTrigger = $('.dialog__trigger'),
		      dialogClose = $('.dialog__close'),
		      dialogTitle = $('.dialog__title'),
		      dialogContent = $('.dialog__content'),
		      dialogAction = $('.dialog__action');

		  // Open the dialog
		  dialogTrigger.on('click', function(e) {
		    dialogBox.toggleClass('dialog--active');
		    e.stopPropagation();
		  });

		  // Close the dialog - click close button
		  dialogClose.on('click', function() {
		    dialogBox.removeClass('dialog--active');
		  });

		  // Close the dialog - press escape key // key#27
		  $(document).keyup(function(e) {
		    if (e.keyCode === 27) {
		      dialogBox.removeClass('dialog--active');
		    }
		  });

		  // Close the dialog - click outside
		  $(document).on('click', function(e) {
		    if ($(e.target).is(dialogBox) === false &&
		        $(e.target).is(dialogTitle) === false &&
		        $(e.target).is(dialogContent) === false &&
		        $(e.target).is(dialogAction) === false) {
		      dialogBox.removeClass('dialog--active');   
		    }
		  });

		}

		// Run function
		$(dialog);  
	</script>
</body>
</html>

(function() {
	var currentException, exceptionDialog, messageContainer, detailExceptionGrid;
	var exceptionDialogMinWidth = 300;
	var exceptionDialogMaxWidth = 800;
	var exceptionDialogMaxHeight = 300;

	dorado.widget.UpdateAction.alertException = function(e) {
		currentException = e;

		$import("grid", function() {
			var dialog = getExceptionDialog();
			dialog.set({
				caption: $resource("dorado.baseWidget.ExceptionDialogTitle"),
				left: undefined,
				top: undefined,
				width: exceptionDialogMaxWidth,
				height: undefined
			});
			dialog._textDom.innerText = dorado.Exception.getExceptionMessage(e) + '\n';
			dialog.show();
		});
	}

	function getExceptionDialog() {
		if (!exceptionDialog) {
			var doms = {};
			var contentDom = $DomUtils.xCreate({
				tagName: "DIV",
				className: "d-exception-content",
				content: [
					{
						tagName: "SPAN",
						className: "d-exception-icon",
						contextKey: "iconDom"
					},
					{
						tagName: "SPAN",
						className: "d-exception-text",
						contextKey: "textDom"
					}
				]
			}, null, doms);
			messageContainer = new dorado.widget.Container({
				contentOverflow: "scroll"
			});
			
			exceptionDialog = new dorado.widget.Dialog({
				center: true,
				modal: true,
				resizeable: true,
				contentOverflow: "visible",
				layout: {
					$type: "Native"
				},
				buttonAlign: "right",
				buttons: [
					{
						caption: $resource("dorado.baseWidget.ExceptionDialogOK"),
						width: 85,
						onClick: function() {
							exceptionDialog.hide();
						}
					}
				],
				afterShow: function(dialog) {
					var buttons = dialog._buttons, button;
					if (buttons) {
						button = buttons[0];
						if (button && button._dom.style.display != "none") {
							button.setFocus();
						}
					}
					dialog.doOnResize();
				},
				beforeShow: function(dialog) {
					showDetailExceptionGrid(currentException);
				}
			});

			var containerDom = exceptionDialog.get("containerDom");
			containerDom.appendChild(contentDom);
			exceptionDialog.addChild(messageContainer);

			exceptionDialog._contentDom = contentDom;
			exceptionDialog._iconDom = doms.iconDom;
			exceptionDialog._textDom = doms.textDom;
		}
		return exceptionDialog;
	}

	function showDetailExceptionGrid(e) {

		function translateMessage(items, messages) {
			messages.each(function(message) {
				var item = dorado.Object.clone(message);
				if (item.entity && item.property) {
					var pd = item.entity.getPropertyDef(item.property);
					if (pd) item.propertyCaption = pd.get("label");
				}
				items.push(item);
			});
		}

		var grid = getDetailExceptionGrid();
		var items = [], validateContext = e.validateContext;

		if (validateContext) {
			if (validateContext.error) translateMessage(items, validateContext.error);
			if (validateContext.warn) translateMessage(items, validateContext.warn);
		}

		grid.set("items", items);
		if (items.length > 0){
			var height = items.length * 28 + 30;
			grid.set("height", height);
			if ((height+200) > exceptionDialogMaxHeight){
				height = exceptionDialogMaxHeight - 200;
			}
			messageContainer.set("height", height);
		}
		else {
			messageContainer.set("height", 1);
			messageContainer.set("visible", false);
		}
	}

	function getDetailExceptionGrid() {
		if (!detailExceptionGrid) {
			detailExceptionGrid = new dorado.widget.Grid({
				readOnly: true,
				dynaRowHeight: true,
				columns: [
					{
						property: "state",
						caption: $resource("dorado.baseWidget.SubmitValidationDetailState"),
						width: 36,
						align: "center",
						onRenderCell: function(self, arg) {
							var iconClass;
							switch(arg.data.state) {
								case "error":
								{
									iconClass = "d-update-action-icon-error";
									break;
								}
								case "warn":
								{
									iconClass = "d-update-action-icon-warn";
									break;
								}
							}

							var $dom = $fly(arg.dom);
							$dom.empty().xCreate({
								tagName: "LABEL",
								className: iconClass,
								style: {
									width: 16,
									height: 16,
									display: "inline-block"
								}
							});
							arg.processDefault = false;
						}
					},
					{
						property: "text",
						caption: $resource("dorado.baseWidget.SubmitValidationDetailMessage"),
						wrappable: true
					},
					{
						property: "property",
						caption: $resource("dorado.baseWidget.SubmitValidationDetailProperty"),
						width: 200,
						resizeable: true,
						onRenderCell: function(self, arg) {
							if (arg.data.propertyCaption && arg.data.propertyCaption != arg.data.property) {
								arg.dom.innerText = arg.data.propertyCaption + "(" + arg.data.property + ")";
								arg.processDefault = false;
							}
							else {
								arg.processDefault = true;
							}
						}
					}
				]
			});
			messageContainer.addChild(detailExceptionGrid);
		}
		return detailExceptionGrid;
	}
})();

var DressCode = Backbone.Model.extend({
	initialize: function() {
		// Initialization magicks will go here
	},
	defaults : {
		id: null,
		event: null,
		styles: null // todo: build this out into a Collections of Styles
	},
	url : function() {
		return this.id ? '/code/' + this.id : '/code';
	}
});

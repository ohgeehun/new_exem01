
// Node object
function Node(id, pid, num, menuIdx, menuType, contents) {

	this.id = id;

	this.pid = pid;

	this.num = num;
	
	this.menuIdx = menuIdx;
	
	this.menuType = menuType;
	
	this.contents = contents;
	
	this.siblingsCount = 0;

	this.wich = 0;	// 동일 레벨 메뉴위치 (1:첫번째 2:중간 3:마지막)

	this.last = false;
	
	this.hasChiled = false;

};

// Tree object
function dTree(objName, svcNick) {

	this.line = {
			
		first				: '../images/tree/tree_first.gif',
		
		last				: '../images/tree/tree_last.gif',
		
		join				: '../images/tree/tree_join.gif',
			
		empty1				: '../images/tree/tree_empty1.gif',
		
		empty2				: '../images/tree/tree_empty2.gif',
		
		oneCiled			: '../images/tree/tree_one_chiled.gif',
		
		firstChiled			: '../images/tree/tree_first_chiled.gif'
	};

	this.obj = objName;
	
	this.svcNick = svcNick;

	this.aNodes = [];

	this.aIndent = [];

	this.root = new Node(-1);

};

// Adds a new node to the node array
dTree.prototype.add = function(id, pid, num, menuIdx, menuType, contents) {
	
	this.aNodes[this.aNodes.length] = new Node(id, pid, num, menuIdx, menuType, contents);
	
};

// Outputs the tree to the page
dTree.prototype.toString = function() {
		
	return this.addNode(this.root);

};

// Creates the tree structure
dTree.prototype.addNode = function(pNode) {

	var str = '';
	for (var n = 0; n<this.aNodes.length; n++) {

		if (this.aNodes[n].pid == pNode.id) {

			var cn = this.aNodes[n];
			this.setCS(cn);
			
			if(cn.pid == -1){

				str += this.addNode(cn);
				
			} else {
				
				str += '<div class="tree3wrap">';
				
				if(cn.pid == 0 && cn.wich == 1){
					str += '<span class="num3_r">'+ this.svcNick +'</span>';
					str += '<img src="../images/icon_step_'+ cn.menuType +'.gif" alt="'+ cn.menuType.toUpperCase() +'" class="padL3"/>';
					str += '<img src="../images/tree3_line2l.gif"/>';
				} else {
					str += '<img src="'+ this.line.empty1 +'"/>';
				}
				
				str += this.indent(cn, n);
				str += this.makeNode(cn);
				
				if(cn.hasChiled){
					
					var firstChiled = '';
					var othorChiled = '';
					for (var i = 0; i < this.aNodes.length; i++) {
						
						if (this.aNodes[i].pid == cn.id){
							
							var chiled = this.aNodes[i];
							this.setCS(chiled);
							
							if(chiled.wich == 1){
								firstChiled += '<img src="'+ this.line.firstChiled +'"/>';
								
								if(chiled.siblingsCount == 1){
									firstChiled += '<img src="'+ this.line.oneCiled +'"/>';
								} else {
									firstChiled += '<img src="'+ this.line.first +'"/>';
								}
								firstChiled += this.makeNode(chiled);
								
							} else {
								othorChiled += '<div class="tree3wrap">';
								othorChiled += '<img src="'+ this.line.empty1 +'"/>';
								
								if(cn.wich == 3 || (cn.wich == 1 && cn.siblingsCount == 1)){
									othorChiled += '<img src="'+ this.line.lineEmpty +'"/>';
								} else {
									othorChiled += '<img src="'+ this.line.empty2 +'"/>';
								}
								
								if(chiled.wich == 2){
									othorChiled += '<img src="'+ this.line.join +'"/>';
								} else {
									othorChiled += '<img src="'+ this.line.last +'"/>';
								}
								othorChiled += this.makeNode(chiled);
								othorChiled += '</div>';
							}
						}
					}
					str += firstChiled;
					str += '</div>';
					str += othorChiled;
				} else {
					str += '</div>';
				}
			}
			this.aIndent.pop();
		}
	}
	return str;
};

//Checks if a node has any children and if it is the last sibling
dTree.prototype.setCS = function(node) {

	var lastId;

	var siblings = [];
	for (var n=0; n<this.aNodes.length; n++) {

		if (this.aNodes[n].pid == node.id) node.hasChiled = true;
		
		if (this.aNodes[n].pid == node.pid){
			
			siblings[siblings.length] = this.aNodes[n].id;
		}
	}
	node.siblingsCount = siblings.length;
	
	if(siblings[0] == node.id){
		node.wich = 1;
	} else if (siblings[siblings.length-1] == node.id){
		node.wich = 3;
	} else {
		node.wich = 2;
	}
	
	if (lastId==node.id) node.last = true;
	else node.last = false;
	
};

dTree.prototype.makeNode = function(node) {
	
	var str = '<span class="num_r">'+ node.num +'번</span>';
	
	if(node.menuType == 'ment'){
		str += '<a style="cursor:pointer;" class="mentLayer"><img src="../images/icon_step_ment.gif" class="padL3"/></a>';
		if(node.mentType == 'M' && node.productType == 2){
			str += '<img src="../images/icon_play_off.gif" class="padL3"/>';
		} else {
			str += '<a href="#"><img src="../images/icon_play_on.gif" class="padL3"/></a>';
		}
		
	} else if(node.menuType == 'sms'){
		str += '<a style="cursor:pointer;" class="smsLayer"><img src="../images/icon_step_sms.gif" class="padL3"/></a>';
		str += '<div style="display: none;"></div>';
		
	} else if(node.menuType == 'mms'){
		str += '<a style="cursor:pointer;" class="mmsLayer"><img src="../images/icon_step_mms.gif" class="padL3"/></a>';
		str += '<div style="display: none;"></div>';
		
	} else {
		str += '<a style="cursor:pointer;" class="callLayer"><img src="../images/icon_step_call.gif" class="padL3"/></a>';
		str += '<div style="display: none;">123132131</div>';
		
	}
	return str;
	
};

// Adds the empty and line icons
dTree.prototype.indent = function(node, nodeId) {

	var str = '';
	if(node.siblingsCount == 1){
		return str += '<img src="' + this.line.firstParentEmpty + '"/>';
	}
	for (var n=0; n<this.aIndent.length; n++){
		if(this.aIndent[n] == 1){
			str += '<img src="' + this.line.empty + '"/>';
		}
	}
	(node.last) ? this.aIndent.push(0) : this.aIndent.push(1);
	
	if(node.wich == 1){
		str += '<img src="' + this.line.first + '"/>';
	} else if(node.wich == 3){
		str += '<img src="' + this.line.last + '"/>';
	} else {
		str += '<img src="' + this.line.join + '"/>';
	}
	return str;

};

//Remove tree node
dTree.prototype.removeNode = function(nodeId) {
	
	for (var i = 0; i < this.aNodes.length; i++) {
		
		if (this.aNodes[i].id == nodeId || this.aNodes[i].pid == nodeId) {
			
			this.aNodes.splice(i,1);
			i--;
		}
	}
};

// Checks chiledren exist in this node
dTree.prototype.isExistChildren = function(nodeId) {
	
	for (var n=0; n<this.aNodes.length; n++) {
		
		if (this.aNodes[n].pid == nodeId) {
			return true;
		}
	}
	return false;
};
Array.prototype.sum = function () {
    var total = 0;
    var i = this.length;

    while (i--) {
        total += this[i];
    }

    return total;
}

function isEmpty(obj) {
    if(obj === undefined || obj === null){
        return true
    }
    if(Array.isArray(obj)) {
        return obj.length === 0
    }
    else{
        return Object.keys(obj).length === 0;
    }
}
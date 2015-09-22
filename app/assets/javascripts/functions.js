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
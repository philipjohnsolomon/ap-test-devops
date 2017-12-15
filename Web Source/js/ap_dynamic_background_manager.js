/**
 * @fileoverview This file contains the JavaScript object which can apply a dynamic backgound styleclass to the body of a page.
 */


/**
 * Define the global 'ap' namespace, if it has not already been defined
 */
var ap = ap || {};

/**
 * Constructs a new DynamicBackgroundManager object.
 * @class This is the basic DynamicBackgroundManager class. Based on the minBackgroundNum and maxBackgroundNum integers provided,
 * it will initialize and retain a random number. When ready, a user can invoke the applyRandomBackground function which will run
 * the following: $('body').addClass('background-' + this.random);
 * @constructor
 * @param minBackgroundNum the <code>minBackgroundNum</code> is the minimum integer value which the random number generator should output
 * @param maxBackgroundNum the <code>maxBackgroundNum</code> is the maximum integer value which the random number generator should output
 * @return A new DynamicBackgroundManager object upon which you should invoke the applyRandomBackground function as needed. 
 */
ap.DynamicBackgroundManager = function (minBackgroundNum, maxBackgroundNum){
	
	/**
	 * The <code>min</code> is the minimum integer value which the random number generator should output
	 */
	this.min = minBackgroundNum;
	
	/**
	 * the <code>maxBackgroundNum</code> is the maximum integer value which the random number generator should output
	 */
	this.max = maxBackgroundNum;
	
	/**
	 * The <code>random</code> integer value which is generated based on the min and max integers provided to the constructor
	 */
	this.random = Math.floor(Math.random() * (this.max -this.min + 1)) + this.min;
	
	/**
	 * Applies a random background class to the body element of the dom in the format 'background-[this.random]':
	 * $('body').addClass('background-' + this.random);
	 */
	this.applyRandomBackground = function() {
		$('body').addClass('background-' + this.random);
	}; 
	
};
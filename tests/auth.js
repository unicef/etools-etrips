var auth = function auth(){  
    this.login = function(){
        browser.get(browser.params.url + '/');        
        element(by.css('input[type="email"]')).clear();
        element(by.css('input[type="email"]')).sendKeys('rey@force.com');
        element(by.css('input[type="password"]')).sendKeys('pass');
        element(by.css('button.button-calm')).click();
        waitForElement('div.title');
    };

    this.logout = function (){
        element(by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon')).click();
        element(by.cssContainingText('.item', 'Logout')).click();
        waitForElement('h2.title.unicef-blue');
        element(by.css('input[type="email"]')).clear();
    };
};

module.exports = new auth();
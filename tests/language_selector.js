describe('Language Selector', function() {
    var sideMenuButton = by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon');

    function switchLanguage(locale, title) {
        var data = require('../www/i18n/' + locale + '.json');
        element(by.cssContainingText('option', title)).click();
        browser.sleep(500);
        element(by.css('input[type="email"]')).getAttribute('placeholder').should.eventually.be.equal(data['template.login.username']);
        element(by.css('input[type="password"]')).getAttribute('placeholder').should.eventually.be.equal(data['template.login.password']);
        element(by.css('div.item-toggle')).getText().should.eventually.equal(data['template.login.remember_me']);
        element(by.css('button')).getText().should.eventually.equal(data['template.login.sign_in']);             
    }

    it('should see the login page', function() {
        browser.get(urlBase + '/');
    });

    it('should have a language selector with four languages', function() {
        element.all(by.css('select > option')).count().should.eventually.equal(4);
    });

    it('should able to select French and display the values in French', function() {
        switchLanguage('fr-FR', 'Français (France)');
    });

    it('should able to switch back to English and display the values in English', function() {
        switchLanguage('en-US', 'English (US)');
    });

    it('should able to view the language selector in the side menu after login', function() {
        auth.login();        
        element(sideMenuButton).click();
        waitForElement('ion-side-menu div.language-select select');
    });

    it('should able to view the to/from date of the first trip in English and then in French', function() {
        element.all(by.css('ion-view[view-title="My Trips"] a.item-content:first-child p:nth-of-type(2)')).first().getText().should.eventually.equal('Jan 1, 2016 -> Dec 31, 2016');
        element(sideMenuButton).click();
        element(by.cssContainingText('ion-side-menu div.language-select select option', 'Français (France)')).click();
        element.all(by.css('ion-view[view-title="My Trips"] a.item-content:first-child p:nth-of-type(2)')).first().getText().should.eventually.equal('1 janv. 2016 -> 31 déc. 2016');
        element(by.cssContainingText('ion-side-menu div.language-select select option', 'English (US)')).click();
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});
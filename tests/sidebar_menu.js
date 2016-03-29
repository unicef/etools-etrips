describe('Sidebar Menu', function() {
    var tabs = ['My Trips', 'Supervised'];
    var sideMenuButton = by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon');

    it('should be able to login', function() {
        auth.login();
    });

    it('should be displayed when the sidemenu bar is clicked', function() {
        element(sideMenuButton).click();
        waitForElement('h1');

        element(by.css('body')).getAttribute('class').then(function(val){
            _.includes(val.split(' '), 'menu-open').should.equal.true;
        });

        element(by.css('h1')).getText().should.eventually.equal('Menu');        
        element.all(by.css('ion-side-menu ion-item.item-complex')).count().should.eventually.equal(2);
    });

    it('should display the Dashboard tab when the Dashboard link is clicked', function() {                
        element(by.linkText('Dashboard')).click();    
        element(by.css('h5')).getText().should.eventually.equal('Dashboard Content');
    });

    it('should display the Settings view', function() {
        element(sideMenuButton).click();
        element(by.linkText('Settings')).click();
        element(by.css('ion-side-menu-content > ion-nav-view > ion-view ion-content h2')).getText().should.eventually.equal('Connection');
        element(by.css('ion-side-menu-content > ion-nav-view > ion-view ion-content h2')).click();

        element.all(by.css('label.item-radio')).count().should.eventually.equal(3);
        element.all(by.css('button[disabled="disabled"]')).count().should.eventually.equal(1);
        element(by.css('input[type="text"]')).sendKeys('c345');
        element.all(by.css('button[disabled="disabled"]')).count().should.eventually.equal(0);

        element(by.css('div[nav-bar="active"] button.back-button')).click();
    });

    it('should be able to logout', function() {
        auth.logout();
    });
});
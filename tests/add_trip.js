describe('Add Trip', function() {
    it('should be able to login', function() {
        auth.login();
    });

    it('should be tap add trip button', function() {
        element(by.id('add_trip')).click();
        waitForElement('button.button-full.button-positive');
        element(by.buttonText('Save Trip')).click();
    });

    it('should be able to logout', function() {
        element(by.css('div[nav-bar="active"] > ion-header-bar button[menu-toggle="left"].ion-navicon')).click();
        element(by.cssContainingText('.item', 'Logout')).click();
        element(by.css('input[type="email"]')).clear();
    });
});
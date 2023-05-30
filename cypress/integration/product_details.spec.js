describe('jungle rails app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  })
  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("Navigates to product detail page", () => {
    cy.get('.products article').first().within(() => {
      cy.get('a').click();
    });
    cy.url().should('include', '/products/');
  });
})
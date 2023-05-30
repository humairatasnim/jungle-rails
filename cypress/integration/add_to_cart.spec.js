describe('jungle rails app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/')
  })
  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it ("Cart increases by one", () => {
    cy.get(".products article").first().find("button")
      .click( {force: true} )
      .then(() => {
        cy.get(".navbar").contains("My Cart (1)")
      })
  });
})
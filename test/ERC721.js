const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ERC-721", () => {
  let accounts, deployer, receiver, erc721;
  describe("Success", () => {
    beforeEach(async () => {
      const ERC721 = await ethers.getContractFactory("ERC721");
      erc721 = await ERC721.deploy("TokenName", "TKN");
      await erc721.deployed();

      accounts = await ethers.getSigners();
      deployer = accounts[0];
      receiver = accounts[1];
    });

    it("Should check the mapping", async () => {
      expect(await erc721.balanceOf(deployer.address)).to.equal(0);
    });
  });

  describe("Failure", () => {
    it("should revert when the input address is zero", async () => {
        await expect(erc721.balanceOf('0x0000000000000000000000000000000000000000')).to.be.reverted;
      });
    });

   
    
});

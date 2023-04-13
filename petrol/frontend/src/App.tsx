import React, { ChangeEvent, useEffect, useState } from "react";
import Web3 from "web3";
import { Contract } from "web3-eth-contract";
// contract
import newPetrolContract from "./blockchain/newPetrolContract";

function App() {
  const [web3, setWeb3] = useState<Web3 | null>(null);
  const [address, setAddress] = useState<String | null>(null);
  const [petrolContract, setPetrolContract] = useState<Contract | null>(null);
  const [inventory, setInventory] = useState<number>(0);
  const [account, setAccount] = useState<number>(0);
  const [inputNum, setInputNum] = useState<number>(0);

  useEffect(() => {
    if (petrolContract) getInvetory();
    if (petrolContract && address) getAccount();
  }, [address, petrolContract]);

  const handleConnectWallet = async () => {
    // connect metamask wallet
    await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    const webObj = new Web3(window.ethereum);
    setWeb3(webObj);
    // address
    const accounts = await webObj.eth.getAccounts();
    if (accounts?.length) {
      setAddress(accounts[0]);
    }
    // contract init
    const contract = newPetrolContract(webObj);
    setPetrolContract(contract);
  };

  const getInvetory = async () => {
    // call func
    const inventoryRes = await petrolContract?.methods.checkBalance().call();
    setInventory(inventoryRes);
  };

  const getAccount = async () => {
    // get public mapping
    const accountRes = await petrolContract?.methods
      .petrolBalances(address)
      .call();
    setAccount(accountRes);
  };

  const handlePurchase = async () => {
    if (!web3 || !petrolContract) {
      alert("Please connect your wallet");
      return;
    } else if (inputNum <= 0) {
      alert("Please enter a positive number");
      return;
    }
    const petrolPrice = web3.utils.toWei("0.001", "ether");
    await petrolContract?.methods.buyPetrol(inputNum).send({
      from: address,
      value: Number(petrolPrice) * inputNum,
    });
  };

  return (
    <div
      style={{
        display: "flex",
        justifyContent: "center",
      }}
    >
      <div>
        <h1>Petrol Exchange Platform</h1>
        <button onClick={handleConnectWallet}>connect wallet</button>
        <h3>Address: {address}</h3>
        <section>
          <div>
            <p>Invetory: {inventory}</p>
          </div>
        </section>
        <section>
          <div>
            <p>Own: {account}</p>
          </div>
        </section>
        <section>
          <div>
            <input
              type="number"
              placeholder="please enter your purchase number.."
              value={inputNum}
              onChange={(e: ChangeEvent<HTMLInputElement>) => {
                const value = !Number.isNaN(e.target.valueAsNumber)
                  ? e.target.valueAsNumber
                  : null;
                if (value) {
                  setInputNum(value);
                }
              }}
            />
            <button onClick={handlePurchase}>BUY</button>
          </div>
        </section>
      </div>
    </div>
  );
}

export default App;

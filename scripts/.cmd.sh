question=$(cat <<EOF
Type number
(-2.1) init and run indexer
(-2) run indexer
(-1) build contracts
(0) create required accounts
(1) redeploy contracts.
(2) deploy contracts
(3) create store
(4) grant minter permission
(5) mint 10 tokens with no royalty
(6) mint 10 tokens with royalty
(7) approve nft to be market listed with auto-transfer
(8) approve nft to be market listed without auto-transfer
(9) make offer to buy nft
(10) accept offer and transfer nft
(11) revoke minter permissions
(12) Batch transfer nft tokens
(13) Batch upgrade stores
(14) Revoke all approvals
EOF
);



function programa() {
  echo "$question";
  read -r response;
  echo "you chose $response";

  case $response in
  -2.1)
    if [ $network = 'mainnet' ]; then
      echo 'we stopped you from doing something dangerous';
    elif [ $network = 'testnet' ]; then
      echo 'we stopped you from doing something dangerous';
   else
       init_and_run_indexer;
    fi
#    init_and_run_indexer & (sleep 2 && create_accounts && deploy);
    programa;
    ;;
  -2)
    run_local_indexer &
    programa;
    ;;
  -1)
    build_contracts;
    programa;
    ;;
  0)
    create_accounts;
    programa;
    ;;
  1)
    redeploy;
    programa;
    ;;
  2)
    deploy;
    programa;
    ;;
  3)
    create_store;
    programa;
    ;;
  4)
    grant_minter;
    programa;
    ;;
  5)
    mint_tokens_nr;
    echo "remember token_id to list in marketplace";
    programa;
    ;;
  6)
    mint_tokens;
    echo "remember token_id to list in marketplace";
    programa;
    ;;
  7)
    echo "enter token_id:";
    read -r token_id;
    nft_approve_autotransfer "$token_id";
    programa;
    ;;
  8)
    echo "enter token_id:";
    read -r token_id;
    nft_approve_manual_transfer "$token_id";
    programa;
    ;;
  9)
    echo "token_id:";
    read -r token_id;
    make_offer "$token_id";
    programa;
    ;;
  10)
    echo "token_id:";
    read -r token_id;
    accept_offer_and_transfer "$token_id";
    programa;
    ;;
  11)
    revoke_minter;
    programa;
    ;;
  12)
    echo "token_id:";
    read -r token_id;
    nft_batch_transfer "$token_id";
    programa;
    ;;
  13)
    batch_upgrade_stores;
    programa;
    ;;
  *)
    echo not a command;
    programa
    ;;
  esac
}
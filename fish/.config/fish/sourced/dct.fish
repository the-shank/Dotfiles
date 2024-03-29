# dct related fish utils
# ----------------------

# virtualfish: event (global)
function venv-activated --on-event virtualenv_did_activate
    echo "The virtualenv" (basename $VIRTUAL_ENV) "was activated"
end

# virtualfish: event (tp_dl)
function venv-activated--tp_dl --on-event virtualenv_did_activate:tp_dl
    cp $HOME/code/dct/tp-data-layer/deploy_data/configs/tp.config.json \
       $HOME/code/dct/tp-data-layer/config.json
end

# virtualfish: event (goods-in)
function venv-activated--goods-in --on-event virtualenv_did_activate:goods-in
    nvm use
end

# virtualfish: event (my-bss)
function venv-activated--my-bss --on-event virtualenv_did_activate:my-bss
    nvm use
end

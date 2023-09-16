#!/usr/bin/bash

vn_engine='Bamboo'
eng_engine='BambooUs'
cur_engine=$(ibus engine)
if [[ $cur_engine = $eng_engine ]]
then
    ibus engine $vn_engine
elif [[ $cur_engine = $vn_engine ]]
then
    ibus engine $eng_engine
fi

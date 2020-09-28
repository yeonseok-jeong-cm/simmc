# Situated Interactive MultiModal Conversations (SIMMC) Challenge 2020

## Model Instructions
task1, task2 base directory: simmc/mm_action_prediction/

### (1) Generate predicted belief state
#### Running model for Task3 and Task2

1. **Preprocess** the datasets to reformat the data for GPT-2 input.

```
$ cd mm_dst
$ ./run_preprocess_gpt2.sh
```
2. **Train** the baseline model

```
$ ./run_train_gpt2.sh [KEYWORD] [GPU_ID]
```

The shell script above repeats the following for both {furniture|fashion} domains.


3. **Generate** ensembled prediction for `devtest|test` data

```
pip uninstall transformers
pip install transformers -t transformers
mv transformers transformers_package
mv transformers_package/transformers transformers
cp modeling_utils.py

$ ./run_generate_using_ensemble.sh [GPU_ID]
```

The generation results are saved in the `/mm_dst/results` folder. Change the `path_output` to a desired path accordingly.


4. **Postprocess** predictions for `devtest|test` data

```
$ ./run_postprocess_gpt2.sh
```

Done! You can now evaluate Task3 and Task2 With generated files in the following directory
```
$ simmc/mm_dst/results/furniture/ensemble/
$ simmc/mm_dst/results/fashion/ensemble/
```

### (2) Preprocess Dataset

preprocess dataset with predicted belief state
```
$ scripts/belief_preprocess_simmc.sh
```

### (3) Train the model
```
$ scripts/belief_simmc_model.sh
$ scripts/belief_simmc_all_model.sh
```

### (4) Inference the model
```
$ scripts/belief_inference_simmc_model.sh
```

### (5) Ensemble models and Generate submission files
ex) --model_types model1 model2 model3 ...

--best_gen model1
    
--model_type inputs are models that used for action prediction and retrieval prediction.

--best_gen inputs is a model that used for response generation


```
$ python ensemble_code/furniture_ensemble.py --model_types HAE_R300 HRE_R300_MAG --best_gen HAE_R300
$ python ensemble_code/fashion_ensemble.py --model_types T_HAE_G300_TD MN_R300_MAG_TD --best_gen MN_G300_TD
```


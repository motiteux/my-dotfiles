#!/bin/bash
rsync -avuzb --exclude 'Outputs' --exclude 'output' --exclude '*.pyc' --exclude '.settings' --exclude '.project' --exclude '.pydevproject' /work/irlin168_1/titeuxm/Developpements/Python/PrometheusLight /work/irlin168_1/titeuxm/PersoFiles/Dropbox/PersoTransfer/

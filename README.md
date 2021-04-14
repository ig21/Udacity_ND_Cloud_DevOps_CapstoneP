# Final Capstone project for Udacity Cloud DevOps Nanodegree


Note: some scripts and templates shared as part of course materials used in the project.

## Step 1 - Scope of the project reflected in the pipeline design

### Pipeline description

- Clone git repository
- Builing nano-app image performing linting as part of the build
- Buidling docker image and pusing to docker hub
- Deploying simple dockerised flask nano-app into AWS EKS in blue/green approach

## Step 2 - Pipeline implemetation 

I decided to choose Jenkins, see below the steps 

- Create an EC2 instance
- Install and configure Jenkins 

## Step 3 - Pick AWS Kubernetes as a Service, or build your own Kubernetes cluster

I have chosen AWS EKS. See steps below to deploy kubernetes. 

Application deployment into AWS EKS are atumated and included as part of capstone-pipeline. 

- Clone this repository to EC2 created in Step 2 
- Create CloudFormation stack using commands below ( yaml and paramters files located in config directory):
    ```
    aws cloudformation create-stack --stack-name eks-cluster --region us-east-1 --template-body file://aws-eks-.yml --parameters file://params.json --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
    ```
- Another option is to use  `eksctl` with `cluster.yaml` by running:
    ```
    eksctl create cluster -f cluster.yaml
    ```
- Configure EKS cluster with EC2 instance using this command:
    ```
    aws eks update-kubeconfig --name nanocluster
    ```
- Copy **role arn** from cloudformation stack outputs into `templates/aws-auth.yml` file.
- Configure `aws-auth.yml` file in order to attach worker nodes to EKS cluster by running:
    ```
    kubectl apply -f aws-auth.yml
    ```
- Deploy initial code to Kubernetes cluster and pods using blue deployment in the `deploy` directory
    ```
    kubectl apply -f blue.yml
    ```
- With `blue` deployment done, you can create the continuous pipeline.
- Configure AWS and Docker globally on Jenkins using the `pipeline-aws` and `docker` plugins.

## Step 4 -  Build your pipeline

Jenkins file reflects the steps descibed in Step1 Pipeline description

## Step 5 Test your pipeline

- Perform builds on your pipeline.
- Verify that your pipeline works as you designed it.
- Take a screenshot of the Circle CI or Jenkins pipeline showing deployment, and a screenshot of your AWS EC2 page showing the newly created (for blue/green) or modified (for rolling) instances. Make sure you name your instances differently between blue and green deployments.

## Manual test of the application deployment 

In order to check what is the URL, go to the Load balancer section in EC2 dashboard  and select specific load balancer. Copy provided DNS and open it in chrome.
You should see the following page:
```
### Hello Udacity!

This is my Capstone project nano application.

Code change can be seen in blue/green deployment approach.	 
```

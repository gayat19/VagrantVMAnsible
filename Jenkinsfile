pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                echo 'Clone from github repository'
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/akilagithub/VagrantVMAnsible.git'
            }
        }
        stage('Provision Infra with Ansible') {
            steps {
                echo 'Provisioning ansible node and controller nodes'
                bat 'vagrant up'
            }
        }
        
        stage('Spin upp ansible and execute playbook'){
            sh '''
            vagrant up
            vagrant ssh acs
            git branch: 'main', changelog: false, poll: false, url: 'https://github.com/akilagithub/VagrantVMAnsible.git'
            ansiblePlaybook installation: 'ansible', playbook: './installdocker.yaml'
            '''
        }
    }
}

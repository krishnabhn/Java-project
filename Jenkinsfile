currentBuild.displayName = "Team-Digital CI/CD Pipeline-#"+currentBuild.number
pipeline {
    environment {
        registry = 'narendrakumar02/aqt_practice_data'
        registryCredential = 'Docker_Token'
        dockerImage = ''
        //scannerHome = tool 'SonarScanner 4.0'
    }
    
    /* agent { docker { image 'maven:latest'
          } } */
    
    agent any
     //tools {
    //maven 'MAVEN_HOME'
  
    stages {
         stage('Building Project') {
         /*   agent { 
                 docker { image 'maven:latest'}
            } */
            steps {
                
                sh 'mvn package'
                sh 'mvn jacoco:prepare-agent test jacoco:report'
            }
        }

        stage('SonarQube analysis') {
            
            /*  agent { 
                docker { image 'sonarqube:latest'}
                 } */
            steps {
               sh 'mvn sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.version=5.6 -Dsonar.login=99846cf336862a47f60c4c5c35c3ce689e7eec81 -Dsonar.organization=qdp-jenkins -Dsonar.projectKey=jenkins-accel'
            }
        }
        
       /* stage("Quality gate") {
            steps {
               //timeout(time: 1, unit: 'MINUTES'){ 
               waitForQualityGate abortPipeline: true
                //}
            }
        }  
        
        stage('Uploading Artifacts') {
           steps {
               script {
                   def server = Artifactory.server 'Artifactory'
                   def buildInfo = Artifactory.newBuildInfo()
                   buildInfo.env.capture = true
                   buildInfo.env.collect()

                   def uploadSpec = """{
                       "files": [{   */
                          // "pattern": "**/target/*.jar",
                         //  "target": "example-repo-local" },
                           //      {
                         // "pattern": "**/target/*.pom",
                         // "target": "example-repo-local"},
                             //    {
                          // "pattern": "**/target/*.war",
                          // "target": "example-repo-local"
                             //   }]
                               //    }"""
                   
                   // server.upload spec: uploadSpec, buildInfo: buildInfo
                   // server.publishBuildInfo buildInfo      
                      // }
              // sh 'curl -X PUT -u admin:password -T target/TestCalculatorAppJuly21Batch.war "http://localhost:8081/artifactory/example-repo-local/target/TestCalculatorAppJuly21Batch.war"'
                //   }
                  //                 } 
  /*  stage('Building Docker Image') {
        steps {

            script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
                echo "Builded Successfully"
                             
            }
        }
    }
    
    stage('Pushing Docker-Image to Dockerhub') {
        steps {
             echo "Pushed Succesfully" 
            script {
                 docker.withRegistry( '', registryCredential ) {
                 dockerImage.push()
                 }
                    }   
        }
    }
    
    stage('Notify Sentry of deployment') {
        environment{
            SENTRY_AUTH_TOKEN = credentials('jenkins-sentry-integration')
            SENTRY_ORG = 'calculator-sentry-organisation'
            SENTRY_PROJECT = 'calculator_sentry_project'
            SENTRY_ENVIRONMENT = 'aqt_production'
            SENTRY_RELEASE='aqt_practice_1.0'
            //SENTRY_RELEASE=$(sentry-cli releases propose-version)
        }
            
        steps {
            sh 'cmd -v sentry-cli || curl -sL https://sentry.io/get-cli/ | bash'
            sh "sentry-cli releases -o $SENTRY_ORG new -p $SENTRY_PROJECT $SENTRY_RELEASE"
            sh "sentry-cli releases set-commits $SENTRY_RELEASE --auto"
            sh "sentry-cli releases files $SENTRY_RELEASE upload-sourcemaps path-to-sourcemaps-if-applicable"
            sh "sentry-cli releases finalize $SENTRY_RELEASE"
            sh "sentry-cli releases -o $SENTRY_ORG deploys $SENTRY_RELEASE new -e $SENTRY_ENVIRONMENT"
        }
    }
    stage('Deploying Docker-Image') {
        steps {
             sh 'docker run -d -p 8085:8080 %registry%:%BUILD_NUMBER%'
             echo "Deployment is Successfull"
             echo "You can access application over given url in the mail"       
             }
    }
} 
post {
     success {
      
      sh 'curl -X POST http://narendrakumar02:113ef214fce5e398d6d59e48b339d74e5b@localhost:8080/job/AQTPracticeData/job/Calculator-Automation_Testing_Pipeline/build?token=h836OjMmws'
      sh 'curl -D- -u narendrakumar02:helo1234 %BUILD_URL%consoleText -o C:/Users/narendrakumar02/Desktop/Assignment/log.txt'
      emailext body: 'Dear Colleague,\nThis is to inform you about Build Success of JOB NAME:$JOB_NAME with BUILD NUMBER:$BUILD_NUMBER with BUILD URL: $BUILD_URL\nPipeline Successfully passed all the stages and Deployed.\nPlease go to BUILD URL and verify the build.\n\nYou can access the deployed application at url: http://localhost:8085/TestCalculatorAppJuly21Batch/ \n\nAutomation Testing Pipeline also triggered successfully.\nFor more information visit refer Automation pipeline.....\n\nThank You\n\nJenkins CI......',
            recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: '$JOB_NAME $BUILD_NUMBER Build Success',
                    to: 'narendra.kumar02@nagarro.com'
    }
       
     failure {
      
      sh 'echo {"fields":{"summary":"Update on Pipeline %JOB_NAME% with BUILD NUMBER %BUILD_NUMBER% have some failure occurred","description":"This issue generated due to Pipeline %JOB_NAME% execution terminated due some problem in occured while running the Build Number:%BUILD_NUMBER%. You can verify the build from following url: %BUILD_URL% .You can also look for the build log attached within the issue.Please check for the problem occurred and try to resolve asap.","issuetype":{"name":"Task"},"project":{"key":"JWA"}}} > test.json'
      sh 'curl -D- -u narendra.kumar02@nagarro.com:mdCER61Dy7SQbG2DOhiW416F -X POST --data-binary "@test.json" -H "Content-Type: application/json" https://narendrakumar02.atlassian.net/rest/api/2/issue/'
      sh 'curl -D- -u narendrakumar02:helo1234 %BUILD_URL%consoleText -o C:/Users/narendrakumar02/Desktop/Assignment/log.txt'
      emailext body: 'Dear Colleague,\nThis is to inform you about failure of JOB NAME:$JOB_NAME with BUILD NUMBER:$BUILD_NUMBER with BUILD URL: $BUILD_URL\nPipeline error\nPlease go to BUILD URL and verify the build.\nA Jira issue must have created for the following build failure.\nFor more information refer related jira dashboard from here https://narendrakumar02.atlassian.net/jira/software/projects/JWA/boards/3/backlog for this projectd.\n\nThank You\n\nJenkins CI......',
            recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: '$JOB_NAME $BUILD_NUMBER Build Failure',
                    to: 'narendra.kumar02@nagarro.com'

    }*/
}           
   }
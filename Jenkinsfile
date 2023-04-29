node{
   stage('SCM Checkout'){
     git 'https://github.com/damodaranj/my-app.git'
   }
   stage('maven-buildstage'){

      def mvnHome =  tool name: 'maven3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
    stage('SonarQube Analysis') {
	        def mvnHome =  tool name: 'maven3', type: 'maven'
	        withSonarQubeEnv('sonar') { 
	          sh "${mvnHome}/bin/mvn sonar:sonar"
	        }
	    }
   stage('Build Docker Image'){
   sh 'docker build -t myimage1/app:0.0.4 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u rajesh2023 -p ${dockerPassword}"
    }
     sh 'docker tag myimage1/app:0.0.4  rajesh2023/project'
     sh 'docker push rajesh2023/project'
   }
   stage('Nexus Image Push'){
   sh 'docker login -u admin -p nexus@123  13.232.188.34:8085'
   sh 'docker tag myimage1/app:0.0.4   13.232.188.34:8085/rajesh:1.0'
   sh 'docker push  13.232.188.34:8085/rajesh:1.0'
   }
     stage('Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception
	}
     stage('Docker deployment'){
   sh 'docker run -d -p 7010:8080 --name apache1 myimage1/app:0.0.4' 
   }
  }
}

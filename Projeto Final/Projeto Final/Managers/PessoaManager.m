//
//  PessoaManager.m
//  Projeto Final
//
//  Created by Leonardo Felipe da Silva on 22/08/14.
//  Copyright (c) 2014 Mack Mobile - BEPiD. All rights reserved.
//

#import "PessoaManager.h"

@implementation PessoaManager

- (Pessoa *)criarPessoa
{
    // Obtem referencia ao AppDelegate
    NSManagedObjectContext *context = [self getContext];
    
    Pessoa *pessoa = [NSEntityDescription insertNewObjectForEntityForName:@"Pessoa" inManagedObjectContext:context];
    
    return pessoa;
}

- (Alergia *)criarAlergia
{
    NSManagedObjectContext *context = [self getContext];
    
    Alergia *alergia = [NSEntityDescription insertNewObjectForEntityForName:@"Alergia" inManagedObjectContext:context];
    
    return alergia;

}

- (Convenio *)criarConvenio
{
    NSManagedObjectContext *context = [self getContext];
    
    Convenio *convenio = [NSEntityDescription insertNewObjectForEntityForName:@"Convenio" inManagedObjectContext:context];
    
    return convenio;
}


- (NSArray *)obterUsuarios
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Pessoa"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

-(NSArray *)obterAlergias
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Alergia"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"substancia" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}

- (NSArray *)obterConvenios
{
    // Obtem o contexto de persistencia que permite executar comando e consultas
    NSManagedObjectContext *context = [self getContext];
    
    // Cria objeto para realizacao de consulta com base em uma entidade
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Convenio"];
    
    //Definindo filtros
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@""];
    //    [request setPredicate:predicate];
    
    //Ordenando os resultados
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //Armazenando os resultados
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    return array;
}


- (void)deletarAlergia:(Alergia *)alergia
{
    [self deletarObjeto:alergia];
}

- (void)deletarPessoa:(Pessoa *)pessoa{
    [self deletarObjeto:pessoa];
}

- (void)deletarConvenio:(Convenio *)convenio
{
    [self deletarObjeto:convenio];
}

- (UIColor *)corDaPessoa:(Pessoa *)pessoa
{
    return (UIColor *)pessoa.cor;
}

- (UIImageView *)criarViewCorBolinhaDaPessoa:(Pessoa *)pessoa naPosicao:(CGPoint)posicao
{
    UIImageView *corView = [[UIImageView alloc] init];
    
    [corView setFrame:CGRectMake(posicao.x, posicao.y, 20, 20)];
    [corView sizeThatFits:CGSizeMake(20, 20)];
    
    corView.layer.backgroundColor = [self corDaPessoa:pessoa].CGColor;
    corView.layer.borderWidth = 2.0f;
    corView.layer.borderColor = [UIColor whiteColor].CGColor;
    corView.layer.masksToBounds = NO;
    corView.layer.cornerRadius = corView.frame.size.height/2;
    corView.clipsToBounds = YES;
    
    return corView;
}

@end
